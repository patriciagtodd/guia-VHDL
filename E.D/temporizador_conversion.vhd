entity temporizador_conversion is
    generic (N_ESPERA : integer := 22);  -- 2^22 ciclos a 25MHz = ~167,77 ms
    port (
        clk            : in  bit;
        rst            : in  bit;
        ventana_activa : out bit;
        fin_ventana    : out bit
    );
end temporizador_conversion;

architecture estructural of temporizador_conversion is

    signal q_espera         : bit_vector(N_ESPERA-1 downto 0);
    signal acc              : bit_vector(N_ESPERA downto 0);  -- cadena de AND, igual que "carry"
    signal pulso_lento      : bit;
    signal ventana_activa_i : bit;
    signal d_va             : bit;
    signal q_cnt            : bit_vector(15 downto 0);        -- 16 bits: 33000 < 2^16
    signal fin_ventana_i    : bit;
    signal reset_cnt        : bit;

begin

    U_ESPERA : entity work.con_gen
        generic map (n => N_ESPERA)
        port map (clk => clk, rst => rst, q => q_espera);

    -- Cadena estructural de AND: detecta "todos los bits en 1" (el valor
    -- maximo del contador), igual mecanismo que el "carry" de con_gen/con_dec
    acc(0) <= '1';
    gen_and: for i in 0 to N_ESPERA-1 generate
        acc(i+1) <= acc(i) and q_espera(i);
    end generate;

    pulso_lento <= acc(N_ESPERA);

    d_va <= pulso_lento or (ventana_activa_i and not fin_ventana_i);

    U_VA : entity work.ffd_sync
        port map (ck => clk, srst => rst, d => d_va, q => ventana_activa_i);

    reset_cnt <= rst or fin_ventana_i;

    U_CNT : entity work.contador_habilitado
        generic map (n => 16)
        port map (clk => clk, rst => reset_cnt,
                   habilita => ventana_activa_i, q => q_cnt);

    -- Fin de ventana cuando q_cnt = 33000 = 1000 0000 1110 1000
    -- (bits 15, 7, 6, 5 y 3 en 1). Es el primer valor, contando desde 0,
    -- que hace que el contador se reinicie en el siguiente pulso de clk.
    -- En el flanco de fin_ventana el reset tiene prioridad, por lo que la
    -- ventana cuenta exactamente 33000 muestras.
    fin_ventana_i <= ventana_activa_i
                  and q_cnt(15) and q_cnt(7) and q_cnt(6) and q_cnt(5) and q_cnt(3);

    ventana_activa <= ventana_activa_i;
    fin_ventana    <= fin_ventana_i;

end estructural;