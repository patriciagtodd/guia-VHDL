entity contador_generico is 
    generic (n : integer := 4); 
    port (
        clk : in  bit;
        srst : in  bit;
        q   : buffer bit_vector(n-1 downto 0)
    );
end contador_generico;

architecture estructural of contador_generico is 

    -- 1. Declaración del componente (Debe tener los mismos nombres que tu entidad ffd_sync)
    component ffd_sync is
        port ( 
            clk   : in  bit;
            srst : in  bit;
            d    : in  bit; -- Esta es la entrada de datos del flip-flop
            q    : out bit  
        );
    end component;

    -- Señales internas
    signal d_inputs : bit_vector(n-1 downto 0);
    signal carry    : bit_vector(n downto 0); 

begin
    -- El primer bit siempre tiene permiso para cambiar
    carry(0) <= '1';

    gen_cont: for i in 0 to n-1 generate
    
        -- 2. Conexión explícita (Mapeo por nombre)
        -- Aquí asociamos los puertos del componente (izquierda) con tus señales (derecha)
        ff_inst: ffd_sync port map (
            clk   => clk,          -- El reloj general va al pin ck
            srst => srst,          -- El reset general va al pin srst
            d    => d_inputs(i),  -- ¡Aquí usamos tu d_inputs! El resultado del XOR entra a la D
            q    => q(i)          -- La salida Q del flip-flop va directo a la salida del contador
        );
        
        -- Lógica del contador
        d_inputs(i) <= q(i) xor carry(i);
        carry(i+1)  <= carry(i) and q(i);
        
    end generate;
    
end estructural;