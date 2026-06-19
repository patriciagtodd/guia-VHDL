entity contador_generico_TB is 
end contador_generico_TB;

architecture simul of contador_generico_TB is 
    signal clk_t : bit := '0';
    signal rst_t : bit;
    signal q_t   : bit_vector(3 downto 0); 

    component contador_generico
        generic (n : integer);
        port (clk, rst : in bit; q : buffer bit_vector(n-1 downto 0));
    end component;

begin
    UUT: contador_generico 
        generic map (n => 4)
        port map (clk_t, rst_t, q_t);

    -- Generador de reloj concurrente: oscila cada 10ns [8]
    clk_t <= not clk_t after 10 ns;

    -- GENERADOR DE RESET CONCURRENTE (Sustituye al process)
    -- Arranca en '1' y cambia a '0' automáticamente a los 15ns [2, 9]
    rst_t <= '1', '0' after 15 ns;

end simul;