entity registro_4bits_en_TB is end registro_4bits_en_TB;

architecture simul of registro_4bits_en_TB is 
    signal clk_t  : bit := '0';
    signal srst_t : bit := '0';
    signal en_t   : bit := '0';
    signal d_t    : bit_vector(3 downto 0) := "0000";
    signal q_t    : bit_vector(3 downto 0);

    component registro_4bits_en
        port (clk, srst, en : in bit; d : in bit_vector(3 downto 0); q : out bit_vector(3 downto 0));
    end component;
begin
    UUT: registro_4bits_en port map (clk_t, srst_t, en_t, d_t, q_t);

    clk_t <= not clk_t after 10 ns; 

    process begin
        
        d_t <= "1010"; wait for 25 ns; 
        
        en_t <= '1'; wait for 20 ns; 
    
        srst_t <= '1'; wait for 20 ns;

        srst_t <= '0';
        
        wait;
    end process;
end simul;