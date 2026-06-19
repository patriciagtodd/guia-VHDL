entity contador_generico is 
    generic (n : integer := 4); 
    port (
        clk : in  bit;
        rst : in  bit;
        q   : buffer bit_vector(n-1 downto 0) 
    );
end contador_generico;

architecture estructural of contador_generico is 
    component contador_generico_ff 
        port (clr, ck, d : in bit; q : out bit);
    end component;

    signal d_inputs : bit_vector(n-1 downto 0);
    signal carry    : bit_vector(n downto 0); 
begin
    -- El primer bit siempre tiene permiso para cambiar (toggle)
    carry(0) <= '1';

    gen_cont: for i in 0 to n-1 generate
        -- Instanciamos el flip-flop i-ésimo
        ff_inst: contador_generico_ff port map (rst, clk, d_inputs(i), q(i));
        
        -- Lógica de contador: el bit cambia si el acarreo llega hasta él
        d_inputs(i) <= q(i) xor carry(i);
        
        -- El acarreo se propaga si el bit actual es 1 y ya venía un acarreo
        carry(i+1) <= carry(i) and q(i);
    end generate;
end estructural;