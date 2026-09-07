entity tb_logica_video is
end tb_logica_video;

architecture sim of tb_logica_video is

    signal clk : bit := '0';
    signal rst : bit := '1';

    signal video_pixel : bit;
    signal h_sync, v_sync : bit;
    signal px, py : bit_vector(9 downto 0);

    -- Digitos de prueba: medicion 1 = 5.23 V (mediciones 2 y 3 en 0.00 V)
    signal u1 : bit_vector(3 downto 0) := "0101";
    signal d1 : bit_vector(3 downto 0) := "0010";
    signal c1 : bit_vector(3 downto 0) := "0011";
    signal u2, d2, c2, u3, d3, c3 : bit_vector(3 downto 0) := "0000";

begin

    DUT : entity work.logica_video
        port map (
            clk_25MHz => clk, rst_global => rst,
            unidad_m1 => u1, decima_m1 => d1, centesima_m1 => c1,
            unidad_m2 => u2, decima_m2 => d2, centesima_m2 => c2,
            unidad_m3 => u3, decima_m3 => d3, centesima_m3 => c3,
            h_sync => h_sync, v_sync => v_sync, video_pixel => video_pixel,
            pixel_x_dbg => px, pixel_y_dbg => py
        );

    -- Reloj de 25MHz -> periodo 40ns
    clk <= not clk after 20 ns;

    -- Reset inicial
    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

    -- Captura las 8 filas de la fuente para la MEDICION 1 (F1),
    -- dejando que vga_sync barra la pantalla solo.
        process
        variable contador     : integer := 0;
        variable capturando   : boolean := false;
        variable linea        : string(1 to 40);
        variable py_anterior  : bit_vector(9 downto 0) := "1111111111";
    begin
        wait until rst = '0';

        loop
            wait until clk = '1' and clk'event;
            wait for 1 ns;

            if py /= py_anterior then
                if py = "0000000000" or py = "0000001000" or py = "0000010000"
                    or py = "0000011000" or py = "0000100000" or py = "0000101000"
                    or py = "0000110000" or py = "0000111000" then
                    capturando := true;
                    contador := 0;
                else
                    capturando := false;
                end if;
                py_anterior := py;
            end if;

            if capturando and contador < 40 and px(2 downto 0) = "000" then
                if video_pixel = '1' then
                    linea(contador + 1) := '#';
                else
                    linea(contador + 1) := '.';
                end if;
                contador := contador + 1;
                if contador = 40 then
                    report linea;
                    capturando := false;
                end if;
            end if;

        end loop;
    end process;
end sim;