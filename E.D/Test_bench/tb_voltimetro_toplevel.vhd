entity tb_voltimetro_toplevel is
end tb_voltimetro_toplevel;


architecture simulacion of tb_voltimetro_toplevel is

    component Voltimetro_toplevel is
        port(
            clk_i : in bit;
            rst_i : in bit;

            data_volt_in_1_i  : in  bit;
            data_volt_out_1_o : out bit;

            data_volt_in_2_i  : in  bit;
            data_volt_out_2_o : out bit;

            data_volt_in_3_i  : in  bit;
            data_volt_out_3_o : out bit;

            hs_o  : out bit;
            vs_o  : out bit;
            red_o : out bit;
            grn_o : out bit;
            blu_o : out bit
        );
    end component;


    signal clk_i : bit;
    signal rst_i : bit;

    signal data_volt_in_1_i  : bit;
    signal data_volt_out_1_o : bit;

    signal data_volt_in_2_i  : bit;
    signal data_volt_out_2_o : bit;

    signal data_volt_in_3_i  : bit;
    signal data_volt_out_3_o : bit;

    signal hs_o  : bit;
    signal vs_o  : bit;

    signal red_o : bit;
    signal grn_o : bit;
    signal blu_o : bit;


begin

    UUT : Voltimetro_toplevel
        port map (
            clk_i => clk_i,
            rst_i => rst_i,

            data_volt_in_1_i  => data_volt_in_1_i,
            data_volt_out_1_o => data_volt_out_1_o,

            data_volt_in_2_i  => data_volt_in_2_i,
            data_volt_out_2_o => data_volt_out_2_o,

            data_volt_in_3_i  => data_volt_in_3_i,
            data_volt_out_3_o => data_volt_out_3_o,

            hs_o  => hs_o,
            vs_o  => vs_o,

            red_o => red_o,
            grn_o => grn_o,
            blu_o => blu_o
        );


    -- Clock de 50 MHz
    clk_i <= not clk_i after 10 ns;


    process
    begin

        -- Reset activo
        rst_i <= '0';

        data_volt_in_1_i <= '0';
        data_volt_in_2_i <= '0';
        data_volt_in_3_i <= '0';

        wait for 100 ns;


        -- Sacamos el reset
        rst_i <= '1';

        -- Canal 1
        data_volt_in_1_i <= '0';
        wait for 1000 ns;

        data_volt_in_1_i <= '1';
        wait for 1000 ns;


        -- Canal 2
        data_volt_in_2_i <= '0';
        wait for 1000 ns;

        data_volt_in_2_i <= '1';
        wait for 1000 ns;


        -- Canal 3
        data_volt_in_3_i <= '0';
        wait for 1000 ns;

        data_volt_in_3_i <= '1';
        wait for 1000 ns;


        wait;

    end process;

end simulacion;