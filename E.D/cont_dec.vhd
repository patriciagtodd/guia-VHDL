entity con_gen is 
    generic (n : integer := 4); -- Parámetro genérico para el ancho de bits
    port (
        clk : in  bit;                                     
        rst : in  bit;                                     
        q   : buffer bit_vector(n-1 downto 0) -- Volvió a "buffer" para poder leerlo internamente
    );
end con_gen;

architecture de_decadas of con_gen is -- Corregido: ahora apunta a con_gen

    component ffd_sync is
        port ( 
            ck   : in  bit;
            srst : in  bit;
            d    : in  bit;
            q    : out bit  
        );
    end component;

    signal d_inputs     : bit_vector(n-1 downto 0);
    signal carry        : bit_vector(n downto 0); 
    signal reset_decada : bit; 

begin
    -- 1. DETECCIÓN DEL NÚMERO 9 (Binario: q(3)='1', q(2)='0', q(1)='1', q(0)='0')
    -- Esto funciona excelente gracias a que q es "buffer"
    reset_decada <= rst or (q(3) and not q(2) and not q(1) and q(0));

    -- El primer bit siempre tiene permiso para cambiar
    carry(0) <= '1';

    gen_cont: for i in 0 to n-1 generate
        ff_inst: ffd_sync port map (
            ck   => clk,
            srst => reset_decada, 
            d    => d_inputs(i),
            q    => q(i)
        );
        
        -- Lógica original de acarreo binario
        d_inputs(i) <= q(i) xor carry(i);
        carry(i+1)  <= carry(i) and q(i);
    end generate;
    
end de_decadas;
