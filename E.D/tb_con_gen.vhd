entity con_gen_tb is
    end con_gen_tb;
    
    architecture sim of con_gen_tb is
        -- 1. Definimos el ancho del contador para la prueba
        constant N_BITS : integer := 4;
        
        -- 2. Señales internas para conectar con el contador
        -- Inicializamos el clk en '0' para evitar valores indefinidos
        signal clk_tb : bit := '0';
        signal rst_tb : bit := '0';
        signal q_tb   : bit_vector(N_BITS-1 downto 0);
    
        -- 3. Declaración del componente que vamos a probar
        component con_gen is
            generic (n : integer := 4); 
            port (
                clk : in  bit;
                rst : in  bit;
                q   : buffer bit_vector(n-1 downto 0) 
            );
        end component;
    
    begin
        -- 4. Instanciación del contador (UUT)
        UUT: con_gen 
            generic map (n => N_BITS)
            port map (clk => clk_tb, rst => rst_tb, q => q_tb);
    
        -- 5. Generador de Reloj (CLK)
        -- Genera un pulso cada 10ns (periodo total de 20ns)
        clk_tb <= not clk_tb after 10 ns;
    
        -- 6. Proceso de Estímulos (Reset y observación)
        process
        begin
            -- Aplicamos Reset inicial para limpiar los FFDs
            rst_tb <= '1';
            wait for 25 ns; -- Esperamos un poco más de un ciclo
            
            -- Soltamos el Reset y dejamos que el contador avance
            rst_tb <= '0';
            
            -- Dejamos que cuente durante varios ciclos
            -- Para 4 bits, debería llegar a 1111 (15) y volver a 0
            wait for 400 ns;
    
            -- Probamos aplicar Reset en medio de la cuenta
            rst_tb <= '1';
            wait for 20 ns;
            rst_tb <= '0';
            
            -- Detenemos la simulación indefinidamente
            wait;
        end process;
    
    end sim;