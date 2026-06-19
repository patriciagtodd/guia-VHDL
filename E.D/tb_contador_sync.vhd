entity tb_contador_generico is
    -- Los testbenches no tienen puertos
    end tb_contador_generico;
    
    architecture sim of tb_contador_generico is
    
        -- 1. Declaración del componente bajo prueba (UUT)
        component contador_generico is
            generic (n : integer := 4);
            port (
                clk : in  bit;
                rst : in  bit;
                q   : buffer bit_vector(n-1 downto 0)
            );
        end component;
    
        -- 2. Constantes de configuración (Tipos nativos: integer y time)
        constant N_BITS     : integer := 4;          
        constant CLK_PERIOD : time    := 20 ns;      
    
        -- 3. Señales de interconexión (Tipos nativos: bit y bit_vector)
        signal clk_tb : bit := '0';
        signal rst_tb : bit := '0';
        signal q_tb   : bit_vector(N_BITS-1 downto 0);
    
    begin
    
        -- 4. Instanciación de la Unidad Bajo Prueba (UUT)
        uut: contador_generico
            generic map (
                n => N_BITS
            )
            port map (
                clk => clk_tb,
                rst => rst_tb,
                q   => q_tb
            );
    
        -- 5. Generación del Reloj (Clock)
        clk_process : process
        begin
            while true loop
                clk_tb <= '0';
                wait for CLK_PERIOD / 2;
                clk_tb <= '1';
                wait for CLK_PERIOD / 2;
            end loop;
            wait; 
        end process;
    
        -- 6. Proceso de Estímulos
        stim_process : process
        begin
            -- Paso 1: Reset inicial obligado
            rst_tb <= '1';
            wait for CLK_PERIOD * 2;
            
            -- Liberamos el reset para que empiece a contar
            rst_tb <= '0';
            
            -- Paso 2: Permitir que cuente hasta desbordarse
            wait for CLK_PERIOD * 20;
    
            -- Paso 3: Probar el botón de reset en medio de una cuenta activa
            rst_tb <= '1';
            wait for CLK_PERIOD * 2;
            rst_tb <= '0';
            
            -- Dejar contar un poco más antes de terminar
            wait for CLK_PERIOD * 5;
    
            -- Fin de la simulación usando un assert nativo
            assert false report "Simulacion terminada" severity failure;
            wait; 
        end process;
    
    end sim;