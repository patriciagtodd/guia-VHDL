entity registro_estructural is
    generic (n : integer := 4);
    port (
        clk  : in  bit;
        rst  : in  bit; -- Reset sincrónico
        ena  : in  bit; -- Enable (Habilitador de carga)
        d    : in  bit_vector(n-1 downto 0);
        q    : out bit_vector(n-1 downto 0)
    );
end registro_estructural;

architecture estructural of registro_estructural is
    -- Componente del FFD con Reset Sincrónico 
    component ffd_sync
        port (ck, srst, d : in bit; q : out bit);
    end component;

    -- Señales para conectar la lógica del habilitador (Enable)
    signal d_con_enable : bit_vector(n-1 downto 0);
    
    -- SEÑAL AUXILIAR: Permite leer el estado actual para la realimentación
    signal q_aux : bit_vector(n-1 downto 0);
begin

    -- Conectamos la señal interna a la salida física del puerto
    q <= q_aux;

    -- Generamos 'n' flip-flops en paralelo
    reg_paralelo: for i in 0 to n-1 generate
        
        -- Lógica del habilitador (Multiplexor estructural): 
        -- Ahora usamos q_aux(i) en lugar de q(i) para evitar el error de lectura [1].
        d_con_enable(i) <= (d(i) and ena) or (q_aux(i) and not ena);

        -- Instanciación de cada bit del registro
        bit_inst: ffd_sync port map (
            ck   => clk,
            srst => rst,
            d    => d_con_enable(i),
            q    => q_aux(i) -- La salida del FF va a la señal auxiliar
        );
    end generate;

end estructural;