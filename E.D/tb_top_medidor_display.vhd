entity tb_top_medidor_display is
end tb_top_medidor_display;

architecture sim of tb_top_medidor_display is

    constant N_ESPERA_TB : integer := 4;

    signal clk : bit := '0';
    signal rst : bit := '1';

    signal d1, d2, d3 : bit := '0';
    signal q1, q2, q3 : bit;

    signal h_sync, v_sync, video_pixel : bit;
    signal px, py : bit_vector(9 downto 0);

begin

    DUT : entity work.top_medidor_display
        generic map (N_ESPERA => N_ESPERA_TB)
        port map (
            clk_25MHz  => clk,
            rst_global => rst,
            d_comparador_m1 => d1, d_comparador_m2 => d2, d_comparador_m3 => d3,
            q_comparador_m1 => q1, q_comparador_m2 => q2, q_comparador_m3 => q3,
            h_sync => h_sync, v_sync => v_sync, video_pixel => video_pixel,
            pixel_x_dbg => px, pixel_y_dbg => py
        );

    clk <= not clk after 20 ns;  -- 25MHz real (periodo 40ns)

    -- Canal 1: 1 de cada 4 -> ~25% (~2.50V)
    process(clk)
        variable i : integer := 0;
    begin
        if clk = '1' and clk'event then
            if i = 0 then d1 <= '1'; else d1 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    -- Canal 2: 1 de cada 2 -> 50% (~5.00V)
    process(clk)
    begin
        if clk = '1' and clk'event then
            d2 <= not d2;
        end if;
    end process;

    -- Canal 3: 3 de cada 4 -> ~75% (~7.50V)
    process(clk)
        variable i : integer := 0;
    begin
        if clk = '1' and clk'event then
            if i < 3 then d3 <= '1'; else d3 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

    -- Captura ASCII de las 3 filas de texto completas
    process
        variable contador    : integer := 0;
        variable capturando  : boolean := false;
        variable linea       : string(1 to 40);
        variable py_anterior : bit_vector(9 downto 0) := "1111111111";
    begin
        wait until rst = '0';

        loop
            wait until clk = '1' and clk'event;
            wait for 1 ns;

            if py /= py_anterior then
                if (py(2 downto 0) = "000") and (py < "0011000000") then
                    capturando := true;
                    contador := 0;
                    if py = "0000000000" then
                        report "----- Medicion 1 -----";
                    elsif py = "0001000000" then
                        report "----- Medicion 2 -----";
                    elsif py = "0010000000" then
                        report "----- Medicion 3 -----";
                    end if;
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