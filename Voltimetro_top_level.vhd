entity Voltimetro_toplevel is
    port(
        clk_i : in bit;
        rst_i : in bit;

        data_volt_in_1_i  : in  bit;   -- pin 89
        data_volt_out_1_o : out bit;   -- pin 87
        data_volt_in_2_i  : in  bit;   -- pin 90
        data_volt_out_2_o : out bit;   -- pin 88
        data_volt_in_3_i  : in  bit;   -- pin 81
        data_volt_out_3_o : out bit;   -- pin 80

        hs_o  : out bit;   -- pin 79
        vs_o  : out bit;   -- pin 99
        red_o : out bit;   -- pin 96
        grn_o : out bit;   -- pin 92
        blu_o : out bit    -- pin 86
    );
end Voltimetro_toplevel;

architecture estructural of Voltimetro_toplevel is

    component ffd_sync is
        port (ck, srst, d : in bit; q : out bit);
    end component;

    component top_medidor_display is
        generic (N_ESPERA : integer := 22);
        port (
            clk_25MHz  : in  bit;
            rst_global : in  bit;
            d_comparador_m1, d_comparador_m2, d_comparador_m3 : in  bit;
            q_comparador_m1, q_comparador_m2, q_comparador_m3 : out bit;
            h_sync, v_sync, video_pixel : out bit;
            pixel_x_dbg, pixel_y_dbg : out bit_vector(9 downto 0)
        );
    end component;

    signal clk25MHz, clk25MHz_n : bit;
    signal video_pixel_i : bit;
    signal px_dbg, py_dbg : bit_vector(9 downto 0);

begin

    clk25MHz_n <= not clk25MHz;

    gen_clk25 : ffd_sync
        port map (ck => clk_i, srst => '0', d => clk25MHz_n, q => clk25MHz);

    U_TOP : top_medidor_display
        generic map (N_ESPERA => 22)
        port map (
            clk_25MHz  => clk25MHz,
            rst_global => rst_i,
            d_comparador_m1 => data_volt_in_1_i,
            d_comparador_m2 => data_volt_in_2_i,
            d_comparador_m3 => data_volt_in_3_i,
            q_comparador_m1 => data_volt_out_1_o,
            q_comparador_m2 => data_volt_out_2_o,
            q_comparador_m3 => data_volt_out_3_o,
            h_sync => hs_o, v_sync => vs_o, video_pixel => video_pixel_i,
            pixel_x_dbg => px_dbg, pixel_y_dbg => py_dbg
        );

    red_o <= video_pixel_i;
    grn_o <= video_pixel_i;
    blu_o <= video_pixel_i;

end estructural;