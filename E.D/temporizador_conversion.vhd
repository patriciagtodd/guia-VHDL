entity temporizador_conversion is
    generic (N_ESPERA : integer := 22);  -- 2^22 ciclos a 25MHz = ~167,77 ms
    port (
        clk            : in  bit;
        rst            : in  bit;
        ventana_activa : out bit;  -- '1' durante los 1000 ciclos de medicion
        fin_ventana    : out bit   -- pulso de 1 ciclo: "listo, capturar y resetear"
    );
end temporizador_conversion;

architecture estructural of temporizador_conversion is

    signal q_espera         : bit_vector(N_ESPERA-1 downto 0);
    signal pulso_lento      : bit;
    signal ventana_activa_i : bit;
    signal d_va             : bit;
    signal q_cnt            : bit_vector(9 downto 0);
    signal fin_ventana_i    : bit;

begin

    -- Contador lento, corre siempre, se desborda cada 2**N_ESPERA ciclos
    U_ESPERA : entity work.con_gen
        generic map (n => N_ESPERA)
        port map (clk => clk, rst => rst, q => q_espera);

    -- "Todos unos" = valor maximo -> AND de todos los bits (sin ningun NOT)
    process(q_espera)
        variable acc : bit;
    begin
        acc := '1';
        for i in 0 to N_ESPERA-1 loop
            acc := acc and q_espera(i);
        end loop;
        pulso_lento <= acc;
    end process;

    -- "Cerrojo" que se prende con pulso_lento y se apaga con fin_ventana
    -- (misma idea que un biestable SR armado con un FFD)
    d_va <= pulso_lento or (ventana_activa_i and not fin_ventana_i);

    U_VA : entity work.ffd_sync
        port map (ck => clk, srst => rst, d => d_va, q => ventana_activa_i);

    -- Contador de 1000 ciclos, solo avanza mientras ventana_activa_i = '1'
    U_CNT : entity work.contador_habilitado
        generic map (n => 10)
        port map (clk => clk, rst => (rst or fin_ventana_i),
                   habilita => ventana_activa_i, q => q_cnt);

    -- Detecta 999 = "1111100111" (mismo truco que end_of_line en vga_sync)
    fin_ventana_i <= ventana_activa_i
                  and q_cnt(9) and q_cnt(8) and q_cnt(7) and q_cnt(6) and q_cnt(5)
                  and (not q_cnt(4)) and (not q_cnt(3))
                  and q_cnt(2) and q_cnt(1) and q_cnt(0);

    ventana_activa <= ventana_activa_i;
    fin_ventana    <= fin_ventana_i;

end estructural;