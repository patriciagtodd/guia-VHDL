entity tb_con_dec is
    -- Los testbenches no tienen puertos
    end tb_con_dec;
    
    architecture sim of tb_con_dec is
    
        -- 1. Declaración del componente bajo prueba (Contador de Décadas)
        component con_dec is
            generic (n : integer := 4);
            port (
                clk : in  bit;
                rst : in  bit;
                q   : buffer bit_vector(n-1 downto 0)
            );
        end component;
    
        -- 2. Constantes para la simulación
        constant N_BITS     : integer := 4;          -- Obligado 4 para ver la década (0 a 9)
        constant CLK_PERIOD : time    := 20 ns;      
    
        -- 3. Señales de interconexión
        signal clk_tb : bit := '0';
        signal rst_tb : bit := '0';
        signal q_tb   : bit_vector(N_BITS-1 downto 0);
    
    begin
    
        -- 4. Instanciación de la Unidad Bajo Prueba (UUT)
        uut: con_dec
            generic map (
                n => N_BITS
            )
            port map (
                clk => clk_tb,
                rst => rst_tb,
                q   => q_tb
            );
    
        -- 5. Generador de Reloj (Clock)
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
            -- Paso 1: Reset inicial para arrancar el circuito de forma limpia
            rst_tb <= '1';
            wait for CLK_PERIOD * 2;
            
            -- Liberamos el reset para que empiece a contar por décadas
            rst_tb <= '0';
            
            -- Paso 2: Dejar correr el tiempo suficiente para ver pasar varios ciclos de décadas.
            -- Como cuenta del 0 al 9, cada 10 ciclos vuelve a empezar.
            -- Al esperar 35 ciclos de reloj, deberías ver en tu gráfica cómo pasa:
            -- 0 -> 1 -> ... -> 9 -> 0 -> 1 -> ... -> 9 -> 0
            wait for CLK_PERIOD * 35;
    
            -- Paso 3: Forzar un reset en medio del conteo (por ejemplo, cuando vaya por el 5 o 6)
            rst_tb <= '1';
            wait for CLK_PERIOD * 2;
            rst_tb <= '0';
            
            -- Unos últimos ciclos para ver que se recupera del reset y sigue contando desde 0
            wait for CLK_PERIOD * 15;
    
            -- Detener la simulación de forma segura
            assert false report "Simulacion de contador por decadas finalizada correctamente" severity failure;
            wait; 
        end process;
    
    end sim;