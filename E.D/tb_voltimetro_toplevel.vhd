entity tb_voltimetro_toplevel is
end tb_voltimetro_toplevel;

architecture sim of tb_voltimetro_toplevel is

    signal clk50 : bit := '0';
    signal rst   : bit := '1';

    signal d1, d2, d3 : bit := '0';
    signal q1, q2, q3 : bit;

    signal hs, vs, red, grn, blu : bit;

    alias px_i        is << signal .tb_voltimetro_toplevel.DUT.px_dbg        : bit_vector(9 downto 0) >>;
    alias py_i         is << signal .tb_voltimetro_toplevel.DUT.py_dbg        : bit_vector(9 downto 0) >>;
    alias vp_i          is << signal .tb_voltimetro_toplevel.DUT.video_pixel_i : bit >>;
    alias clk25_probe is << signal .tb_voltimetro_toplevel.DUT.clk25MHz      : bit >>;

begin

    DUT : entity work.Voltimetro_toplevel
        port map (
            clk_i => clk50, rst_i => rst,
            data_volt_in_1_i => d1, data_volt_out_1_o => q1,
            data_volt_in_2_i => d2, data_volt_out_2_o => q2,
            data_volt_in_3_i => d3, data_volt_out_3_o => q3,
            hs_o => hs, vs_o => vs, red_o => red, grn_o => grn, blu_o => blu
        );

    clk50 <= not clk50 after 10 ns;  -- 50 MHz real (periodo 20 ns)

    -- Canal 1: ~25%
    process(clk50)
        variable i : integer := 0;
    begin
        if clk50 = '1' and clk50'event then
            if i = 0 then d1 <= '1'; else d1 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    -- Canal 2: ~50%
    process(clk50)
    begin
        if clk50 = '1' and clk50'event then
            d2 <= not d2;
        end if;
    end process;

    -- Canal 3: ~75%
    process(clk50)
        variable i : integer := 0;
    begin
        if clk50 = '1' and clk50'event then
            if i < 3 then d3 <= '1'; else d3 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    process
    begin
        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait;
    end process;

    -- Captura ASCII de las 3 filas, misma logica ya validada en
    -- tb_top_medidor_display, pero disparada por clk25_probe (interno)
    process
        variable contador    : integer := 0;
        variable capturando  : boolean := false;
        variable linea       : string(1 to 40);
        variable py_anterior : bit_vector(9 downto 0) := "1111111111";
    begin
        wait until rst = '0';

        report "----- Medicion 1 -----";
        if vp_i = '1' then
            linea(1) := '#';
        else
            linea(1) := '.';
        end if;
        contador    := 1;
        capturando  := true;
        py_anterior := py_i;

        loop
            wait until clk25_probe = '1' and clk25_probe'event;
            wait for 1 ns;

            if py_i /= py_anterior then
                if (py_i(2 downto 0) = "000") and (py_i < "0011000000") then
                    capturando := true;
                    contador := 0;
                    if py_i = "0001000000" then
                        report "----- Medicion 2 -----";
                    elsif py_i = "0010000000" then
                        report "----- Medicion 3 -----";
                    end if;
                else
                    capturando := false;
                end if;
                py_anterior := py_i;
            end if;

            if capturando and contador < 40 and px_i(2 downto 0) = "000" then
                if vp_i = '1' then
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
