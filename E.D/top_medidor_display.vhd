entity top_medidor_display is
    generic (N_ESPERA : integer := 22);
    port (
        clk_25MHz  : in  bit;
        rst_global : in  bit;

        -- Entradas de los 3 comparadores (nodo RC externo de cada canal)
        d_comparador_m1 : in bit;
        d_comparador_m2 : in bit;
        d_comparador_m3 : in bit;

        -- Realimentacion hacia el RC externo
        q_comparador_m1 : out bit;
        q_comparador_m2 : out bit;
        q_comparador_m3 : out bit;

        h_sync      : out bit;
        v_sync      : out bit;
        video_pixel : out bit;
        pixel_x_dbg : out bit_vector(9 downto 0);
        pixel_y_dbg : out bit_vector(9 downto 0)
    );
end top_medidor_display;

architecture estructural of top_medidor_display is

    signal u1, d1, c1 : bit_vector(3 downto 0);
    signal u2, d2, c2 : bit_vector(3 downto 0);
    signal u3, d3, c3 : bit_vector(3 downto 0);

    signal ventana_dbg, fin_dbg : bit;  -- no se usan, pero hay que conectarlas igual

begin

    U_MEDIDOR : entity work.medidor_voltaje
        generic map (N_ESPERA => N_ESPERA)
        port map (
            clk => clk_25MHz, rst => rst_global,
            d_comparador_m1 => d_comparador_m1,
            d_comparador_m2 => d_comparador_m2,
            d_comparador_m3 => d_comparador_m3,
            q_comparador_m1 => q_comparador_m1,
            q_comparador_m2 => q_comparador_m2,
            q_comparador_m3 => q_comparador_m3,
            unidad_m1 => u1, decima_m1 => d1, centesima_m1 => c1,
            unidad_m2 => u2, decima_m2 => d2, centesima_m2 => c2,
            unidad_m3 => u3, decima_m3 => d3, centesima_m3 => c3,
            ventana_activa_dbg => ventana_dbg,
            fin_ventana_dbg    => fin_dbg
        );

    U_VIDEO : entity work.logica_video
        port map (
            clk_25MHz => clk_25MHz, rst_global => rst_global,
            unidad_m1 => u1, decima_m1 => d1, centesima_m1 => c1,
            unidad_m2 => u2, decima_m2 => d2, centesima_m2 => c2,
            unidad_m3 => u3, decima_m3 => d3, centesima_m3 => c3,
            h_sync => h_sync, v_sync => v_sync, video_pixel => video_pixel,
            pixel_x_dbg => pixel_x_dbg, pixel_y_dbg => pixel_y_dbg
        );

end estructural;
