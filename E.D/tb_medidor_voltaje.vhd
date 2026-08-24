entity tb_medidor_voltaje is
end tb_medidor_voltaje;

architecture sim of tb_medidor_voltaje is

    constant N_ESPERA_TB : integer := 4;

    signal clk : bit := '0';
    signal rst : bit := '1';

    signal d1, d2, d3 : bit := '0';
    signal q1, q2, q3 : bit;

    signal u1, dec1, c1 : bit_vector(3 downto 0);
    signal u2, dec2, c2 : bit_vector(3 downto 0);
    signal u3, dec3, c3 : bit_vector(3 downto 0);

    signal ventana_dbg, fin_dbg : bit;

begin

    DUT : entity work.medidor_voltaje
        generic map (N_ESPERA => N_ESPERA_TB)
        port map (
            clk => clk, rst => rst,
            d_comparador_m1 => d1, d_comparador_m2 => d2, d_comparador_m3 => d3,
            q_comparador_m1 => q1, q_comparador_m2 => q2, q_comparador_m3 => q3,
            unidad_m1 => u1, decima_m1 => dec1, centesima_m1 => c1,
            unidad_m2 => u2, decima_m2 => dec2, centesima_m2 => c2,
            unidad_m3 => u3, decima_m3 => dec3, centesima_m3 => c3,
            ventana_activa_dbg => ventana_dbg, fin_ventana_dbg => fin_dbg
        );

    clk <= not clk after 10 ns;

    -- Canal 1: 1 de cada 4 -> ~25% (~2.50V)
    process(clk)
        variable i : integer := 0;
    begin
        if clk = '1' and clk'event then
            if i = 0 then d1 <= '1'; else d1 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    -- Canal 2: 1 de cada 2 -> 50% (~5.00V)
    process(clk)
    begin
        if clk = '1' and clk'event then
            d2 <= not d2;
        end if;
    end process;

    -- Canal 3: 3 de cada 4 -> ~75% (~7.50V)
    process(clk)
        variable i : integer := 0;
    begin
        if clk = '1' and clk'event then
            if i < 3 then d3 <= '1'; else d3 <= '0'; end if;
            i := (i + 1) mod 4;
        end if;
    end process;

    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

end sim;