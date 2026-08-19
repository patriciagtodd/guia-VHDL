entity medidor_voltaje is
    port (
        clk, rst : in bit;

        -- Entradas de los 3 comparadores FFD (D = nodo del RC externo de cada medicion)
        d_comparador_m1 : in bit;
        d_comparador_m2 : in bit;
        d_comparador_m3 : in bit;

        -- Realimentacion hacia el RC externo (va a un pin de la FPGA por canal)
        q_comparador_m1 : out bit;
        q_comparador_m2 : out bit;
        q_comparador_m3 : out bit;

        unidad_m1, decima_m1, centesima_m1 : out bit_vector(3 downto 0);
        unidad_m2, decima_m2, centesima_m2 : out bit_vector(3 downto 0);
        unidad_m3, decima_m3, centesima_m3 : out bit_vector(3 downto 0)
    );
end medidor_voltaje;

architecture estructural of medidor_voltaje is
    signal ventana_activa, fin_ventana : bit;
    signal q1, q2, q3 : bit;
begin

    U_TIEMPO : entity work.temporizador_conversion
        generic map (N_ESPERA => 22)
        port map (clk => clk, rst => rst, ventana_activa => ventana_activa, fin_ventana => fin_ventana);

    -- Comparadores de 1 bit (FFD): muestrean el nodo RC a 25MHz
    U_COMP1 : entity work.ffd_sync port map (ck => clk, srst => '0', d => d_comparador_m1, q => q1);
    U_COMP2 : entity work.ffd_sync port map (ck => clk, srst => '0', d => d_comparador_m2, q => q2);
    U_COMP3 : entity work.ffd_sync port map (ck => clk, srst => '0', d => d_comparador_m3, q => q3);

    q_comparador_m1 <= q1;
    q_comparador_m2 <= q2;
    q_comparador_m3 <= q3;

    U_CH1 : entity work.conversor_sigmadelta_bcd
        port map (clk => clk, rst => rst, q_bitstream => q1,
                   ventana_activa => ventana_activa, fin_ventana => fin_ventana,
                   unidad => unidad_m1, decima => decima_m1, centesima => centesima_m1);

    U_CH2 : entity work.conversor_sigmadelta_bcd
        port map (clk => clk, rst => rst, q_bitstream => q2,
                   ventana_activa => ventana_activa, fin_ventana => fin_ventana,
                   unidad => unidad_m2, decima => decima_m2, centesima => centesima_m2);

    U_CH3 : entity work.conversor_sigmadelta_bcd
        port map (clk => clk, rst => rst, q_bitstream => q3,
                   ventana_activa => ventana_activa, fin_ventana => fin_ventana,
                   unidad => unidad_m3, decima => decima_m3, centesima => centesima_m3);

end estructural;
