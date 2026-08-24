entity tb_conversor_sigmadelta_bcd is
end tb_conversor_sigmadelta_bcd;

architecture sim of tb_conversor_sigmadelta_bcd is

    constant N_ESPERA_TB : integer := 4;

    signal clk            : bit := '0';
    signal rst            : bit := '1';
    signal ventana_activa : bit;
    signal fin_ventana    : bit;

    signal q_bitstream : bit := '0';
    signal modo_denso  : bit := '0';  -- '0' = 50%, '1' = todo en '1' (simula ~9.99V)

    signal unidad, decima, centesima : bit_vector(3 downto 0);

begin

    U_TIEMPO : entity work.temporizador_conversion
        generic map (N_ESPERA => N_ESPERA_TB)
        port map (clk => clk, rst => rst,
                   ventana_activa => ventana_activa, fin_ventana => fin_ventana);

    DUT : entity work.conversor_sigmadelta_bcd
        port map (
            clk => clk, rst => rst,
            q_bitstream => q_bitstream,
            ventana_activa => ventana_activa, fin_ventana => fin_ventana,
            unidad => unidad, decima => decima, centesima => centesima
        );

    clk <= not clk after 10 ns;

    -- Bitstream: arranca en densidad ~50%, y despues del primer fin_ventana
    -- pasa a densidad ~100% (deberia verse el registro saltar a otro valor)
    process(clk)
    begin
        if clk = '1' and clk'event then
            if modo_denso = '0' then
                q_bitstream <= not q_bitstream;  -- 50%
            else
                q_bitstream <= '1';              -- ~100%
            end if;
        end if;
    end process;

    process
    begin
        wait until fin_ventana = '1';
        wait until fin_ventana = '0';
        modo_denso <= '1';  -- a partir de aca, cambia la densidad
        wait;
    end process;

    process
    begin
        rst <= '1';
        wait for 45 ns;
        rst <= '0';
        wait;
    end process;

end sim;