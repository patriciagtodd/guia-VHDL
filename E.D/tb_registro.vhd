
entity testbench_reg is
end testbench_reg;

architecture sim of testbench_reg is
    -- 1. Definimos el ancho del registro para la prueba
    constant N_BITS : integer := 4;
    
    -- 2. Señales internas para conectar con el registro
    signal clk_tb  : bit := '0';
    signal rst_tb  : bit := '0';
    signal ena_tb  : bit := '0';
    signal d_tb    : bit_vector(N_BITS-1 downto 0) := "0000";
    signal q_tb    : bit_vector(N_BITS-1 downto 0);

    -- 3. Declaración del componente que vamos a probar
    component registro_estructural is
        generic (n : integer := 4);
        port (
            clk  : in  bit;
            rst  : in  bit;
            ena  : in  bit;
            d    : in  bit_vector(n-1 downto 0);
            q    : out bit_vector(n-1 downto 0)
        );
    end component;

begin
    -- 4. Instanciación de la Unidad Bajo Prueba (UUT)
    UUT: registro_estructural 
        generic map (n => N_BITS)
        port map (
            clk => clk_tb, 
            rst => rst_tb, 
            ena => ena_tb, 
            d   => d_tb, 
            q   => q_tb
        );

    -- 5. Generador de Reloj (CLK): Periodo de 20ns
    clk_tb <= not clk_tb after 10 ns;

    -- 6. Proceso de Estímulos
    process
    begin
        -- Estado inicial: Reset sincrónico
        rst_tb <= '1';
        wait for 25 ns; 
        rst_tb <= '0';
        wait for 5 ns;

        -- PRUEBA 1: Intentar cargar dato con ENABLE en '0'
        d_tb <= "1010"; 
        ena_tb <= '0';
        wait for 40 ns; -- Pasan dos flancos de reloj
        -- Aquí q_tb DEBE seguir en "0000" porque ena está en '0'.

        -- PRUEBA 2: Cargar dato con ENABLE en '1'
        ena_tb <= '1';
        wait for 20 ns; -- Esperamos un flanco de subida
        -- Aquí q_tb DEBE cambiar a "1010".

        -- PRUEBA 3: Cambiar la entrada pero quitar el ENABLE
        ena_tb <= '0';
        d_tb <= "1111"; 
        wait for 40 ns;
        -- Aquí q_tb DEBE mantener "1010" (Memoria), ignorando el "1111".

        -- PRUEBA 4: Reset en medio de la operación
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';
        -- Aquí q_tb DEBE volver a "0000" en el flanco.

        wait; -- Fin de la simulación
    end process;

end sim;
