entity tb_voltimetro_toplevel is
end tb_voltimetro_toplevel;

architecture sim of tb_voltimetro_toplevel is

    signal clk50 : bit := '0';
    signal rst   : bit := '1';

    signal d1, d2, d3 : bit := '0';
    signal q1, q2, q3 : bit;

    signal hs, vs, red, grn, blu : bit;

    signal hsync_edges : integer := 0;
    signal vsync_edges : integer := 0;

begin

    DUT : entity work.Voltimetro_toplevel
        port map (
            clk_i => clk50,
            rst_i => rst,

            data_volt_in_1_i  => d1,
            data_volt_out_1_o => q1,
            data_volt_in_2_i  => d2,
            data_volt_out_2_o => q2,
            data_volt_in_3_i  => d3,
            data_volt_out_3_o => q3,

            hs_o  => hs,
            vs_o  => vs,
            red_o => red,
            grn_o => grn,
            blu_o => blu
        );

    -- Reloj de 50 MHz
    clk50 <= not clk50 after 10 ns;

    -- Canal 1: ciclo útil aproximado de 25 %
    process (clk50)
        variable i : integer := 0;
    begin
        if clk50'event and clk50 = '1' then
            if i = 0 then
                d1 <= '1';
            else
                d1 <= '0';
            end if;

            i := (i + 1) mod 4;
        end if;
    end process;

    -- Canal 2: ciclo útil aproximado de 50 %
    process (clk50)
    begin
        if clk50'event and clk50 = '1' then
            d2 <= not d2;
        end if;
    end process;

    -- Canal 3: ciclo útil aproximado de 75 %
    process (clk50)
        variable i : integer := 0;
    begin
        if clk50'event and clk50 = '1' then
            if i < 3 then
                d3 <= '1';
            else
                d3 <= '0';
            end if;

            i := (i + 1) mod 4;
        end if;
    end process;

    -- Reset inicial
    process
    begin
        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait;
    end process;

    -- Cuenta transiciones de sincronismo horizontal.
    process (hs)
    begin
        if rst = '0' and hs'event then
            hsync_edges <= hsync_edges + 1;
        end if;
    end process;

    -- Cuenta transiciones de sincronismo vertical.
    process (vs)
    begin
        if rst = '0' and vs'event then
            vsync_edges <= vsync_edges + 1;
        end if;
    end process;

    -- Verificación: 20 ms alcanza para observar varias líneas VGA
    -- y al menos un ciclo vertical.
    process
    begin
        wait until rst = '0';
        wait for 20 ms;

        assert hsync_edges > 100
            report "ERROR: hs_o no presenta suficientes transiciones."
            severity error;

        assert vsync_edges > 0
            report "ERROR: vs_o no presenta transiciones."
            severity error;

        report "OK: hs_o y vs_o generan sincronismo.";

        wait;
    end process;

end sim;