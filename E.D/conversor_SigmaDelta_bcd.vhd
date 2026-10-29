entity conversor_sigmadelta_bcd is
    port (
        clk            : in  bit;
        rst            : in  bit;
        q_bitstream    : in  bit;   -- salida del FFD comparador de este canal
        ventana_activa : in  bit;   -- viene del temporizador_conversion (compartido)
        fin_ventana    : in  bit;   -- viene del temporizador_conversion (compartido)

        unidad    : out bit_vector(3 downto 0);
        decima    : out bit_vector(3 downto 0);
        centesima : out bit_vector(3 downto 0)
    );
end conversor_sigmadelta_bcd;

architecture estructural of conversor_sigmadelta_bcd is
    -- Ventana de N = 33000 muestras con Vref = 3.3 V:
    --   cuenta = N * Vin / Vref = 10000 * Vin  DIEZ MIL PORQUE UUSO 5 BCD
    -- => 5 digitos BCD  U . D C M Z  (volts, decimas, centesimas, milesimas, diezmilesimas)
    -- Solo se muestran U, D, C; M y Z se usan para promediar y no tienen registro.
    signal reset_conteo    : bit;
    signal habilita_cuenta : bit;
    signal d_diezmilesima, d_milesima : bit_vector(3 downto 0);
    signal d_centesima, d_decima, d_unidad : bit_vector(3 downto 0);
    signal carry_z, carry_m, carry_c, carry_d : bit;
begin
    reset_conteo    <= rst or fin_ventana;
    habilita_cuenta <= ventana_activa and q_bitstream;

    -- Digitos que NO se muestran (menos significativos)
    U_DIEZMILESIMA : entity work.decada_bcd
        port map (clk => clk, rst => reset_conteo, habilita => habilita_cuenta,
                   q => d_diezmilesima, carry_out => carry_z);

    U_MILESIMA : entity work.decada_bcd
        port map (clk => clk, rst => reset_conteo, habilita => carry_z,
                   q => d_milesima, carry_out => carry_m);

    -- Digitos que SI se muestran
    U_CENTESIMA : entity work.decada_bcd
        port map (clk => clk, rst => reset_conteo, habilita => carry_m,
                   q => d_centesima, carry_out => carry_c);

    U_DECIMA : entity work.decada_bcd
        port map (clk => clk, rst => reset_conteo, habilita => carry_c,
                   q => d_decima, carry_out => carry_d);

    U_UNIDAD : entity work.decada_bcd
        port map (clk => clk, rst => reset_conteo, habilita => carry_d,
                   q => d_unidad, carry_out => open);

    -- Registros de salida: solo los 3 digitos visibles
    U_REG_C : entity work.registro_estructural generic map (n => 4)
        port map (clk => clk, rst => rst, ena => fin_ventana, d => d_centesima, q => centesima);
    U_REG_D : entity work.registro_estructural generic map (n => 4)
        port map (clk => clk, rst => rst, ena => fin_ventana, d => d_decima, q => decima);
    U_REG_U : entity work.registro_estructural generic map (n => 4)
        port map (clk => clk, rst => rst, ena => fin_ventana, d => d_unidad, q => unidad);
end estructural;