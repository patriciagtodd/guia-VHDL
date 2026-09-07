entity tb_temporizador_conversion is
end tb_temporizador_conversion;

architecture sim of tb_temporizador_conversion is

    constant N_ESPERA_TB : integer := 4;  -- reducido: 2**4 = 16 ciclos de espera (en vez de 2**22)

    signal clk            : bit := '0';
    signal rst            : bit := '1';
    signal ventana_activa : bit;
    signal fin_ventana    : bit;

begin

    DUT : entity work.temporizador_conversion
        generic map (N_ESPERA => N_ESPERA_TB)
        port map (
            clk            => clk,
            rst            => rst,
            ventana_activa => ventana_activa,
            fin_ventana    => fin_ventana
        );

    -- Reloj de simulacion: periodo 20 ns
    clk <= not clk after 10 ns;

    process
    begin
        rst <= '1';
        wait for 45 ns;
        rst <= '0';
        wait;
    end process;

end sim;