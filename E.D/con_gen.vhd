entity con_gen is 
    generic (n : integer := 4); -- Parámetro genérico para el ancho de bits
    port (
        clk : in  bit;                          
        rst : in  bit;                          
        q   : out bit_vector(n-1 downto 0)      
    );
end con_gen;

architecture estructural of con_gen is 
    -- Declaración del componente interno
    component ffd_sync 
        port (ck, srst, d : in bit; q : out bit);
    end component;

    -- Señales internas de interconexión
    signal d_inputs : bit_vector(n-1 downto 0);
    signal carry    : bit_vector(n downto 0); 
    signal q_aux    : bit_vector(n-1 downto 0); 

begin
    -- Feedback de la salida auxiliar hacia el puerto de salida
    q <= q_aux;

    -- Lógica del Acarreo inicial (permite que el bit 0 conmute siempre)
    carry(0) <= '1'; 
        
    -- Instanciación repetitiva mediante GENERATE
    gen_cont: for i in 0 to n-1 generate
        -- Conexión de cada bit a un Flip-Flop D
        ff_inst: ffd_sync port map (
            ck   => clk, 
            srst => rst, 
            d    => d_inputs(i), 
            q    => q_aux(i) 
        );
        
        -- Lógica de próximo estado bit a bit (Toggle estructural)
        -- d = q XOR carry_in (Determina si el bit debe cambiar)
        d_inputs(i) <= q_aux(i) xor carry(i);
        
        -- Propagación del acarreo
        -- carry_out = carry_in AND q (El acarreo pasa al siguiente si el actual es 1)
        carry(i+1) <= carry(i) and q_aux(i);
    end generate;

end estructural;