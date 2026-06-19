entity testbench is end testbench;

architecture simul of testbench is 
    
    signal clk_t   : bit := '1'; 
    signal reset_t : bit := '0';
    signal X_t     : bit := '0';
    signal S_t     : bit;

    component detector_110 port (
    clk : in bit;
    reset : in bit;
    X : in bit;
    S : out bit); 
    end component;
begin
    UUT: detector_110 port map (clk_t, reset_t, X_t, S_t);

    -- El bloque del profe tiene cada 10ns un periodo de reloj, entonces cambia cada 5ns.
    clk_t <= not clk_t after 5 ns;

    -- Flancos de subida en: 0ns, 10ns, 20ns, 30ns, 40ns... igual que la Fig 2.

    process begin
        
        --De 0 a 15 ns la entrada de bits vale 0 
        --De 15 ns a 35 ns la entrada sube a 1 (Dura 20 ns encendida
        --De 35 ns a 75 ns la entrada baja a 0 (Dura 40 ns apagada)
        --De 75 ns a 115 ns la entrada vuelve a subir a 1 (Dura 40 ns encendida)
        --De 115 ns en adelante baja a 0.

        -- --- t = 0 ns ---
        reset_t <= '1';
        X_t     <= '0';

        wait for 5 ns; -- reset antes de empezar la simulación (t=0ns)
        
        -- aca arranca en 0 --- t = 5 ns ---
        reset_t <= '0';
        wait for 10 ns; 
        
        -- sube a 1 --- t = 15 ns --- 
        X_t <= '1'; 
        wait for 20 ns; -- Se mantiene en '1' por 20 ns (hasta t = 35 ns)
        
        -- baja --- t = 35 ns --- 
        X_t <= '0'; 
        wait for 40 ns; -- Se mantiene en '0' por 40 ns (hasta t = 75 ns)
        
        -- sube --- t = 75 ns --- 
        X_t <= '1'; 
        wait for 40 ns; -- Se mantiene en '1' por 40 ns (hasta t = 115 ns)
        
        -- baja --- t = 115 ns --- 
        X_t <= '0'; 
        
        wait; -- se acaba
    end process;

end simul;