entity tb_conversor_sigmadelta_bcd is
end tb_conversor_sigmadelta_bcd;

architecture sim of tb_conversor_sigmadelta_bcd is

    constant N_ESPERA_TB : integer := 4;  -- espera reducida: 2**4 = 16 ciclos

    signal clk            : bit := '0';
    signal rst            : bit := '1';
    signal ventana_activa : bit;
    signal fin_ventana    : bit;

    signal q_bitstream : bit := '0';

    signal unidad, decima, centesima : bit_vector(3 downto 0);

begin

    -- Mismo temporizador que ya validaste, reutilizado tal cual
    U_TIEMPO : entity work.temporizador_conversion
        generic map (N_ESPERA => N_ESPERA_TB)
        port map (clk => clk, rst => rst,
                   ventana_activa => ventana_activa, fin_ventana => fin_ventana);

    DUT : entity work.conversor_sigmadelta_bcd
        port map (
            clk            => clk,
            rst            => rst,
            q_bitstream    => q_bitstream,
            ventana_activa => ventana_activa,
            fin_ventana    => fin_ventana,
            unidad         => unidad,
            decima         => decima,
            centesima      => centesima
        );

    -- Reloj de simulacion: periodo 20 ns
    clk <= not clk after 10 ns;

    -- Bitstream de prueba: densidad 50% (un '1' cada 2 flancos),
    -- simula ~5.00V segun lo que planteo la catedra
    process(clk)
    begin
        if clk = '1' and clk'event then
            q_bitstream <= not q_bitstream;
        end if;
    end process;

    process
    begin
        rst <= '1';
        wait for 45 ns;
        rst <= '0';
        wait;
    end process;

end sim;