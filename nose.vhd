entity registro_4bits_en is 
    port ( 
        clk, srst, en : in  bit; 
        d             : in  bit_vector(3 downto 0); 
        q             : out bit_vector(3 downto 0) 
    );
end registro_4bits_en;

architecture estructural of registro_4bits_en is 
    component registro_4bits_en_ff port (clr, ck, d : in bit; q : out bit); end component;
    signal d_ff  : bit_vector(3 downto 0);
    signal q_int : bit_vector(3 downto 0); 
begin

   
    
    gen_logic: for i in 0 to 3 generate
        d_ff(i) <= (not srst) and ((en and d(i)) or (not en and q_int(i)));
    end generate;


    gen_regs: for i in 0 to 3 generate
        FF: registro_4bits_en_ff port map (clr => '0', ck => clk, d => d_ff(i), q => q_int(i));
    end generate;


    q <= q_int;

end estructural;
