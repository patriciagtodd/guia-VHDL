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
    -- Componente del FFD con Reset Sincrónico que ya definimos
    component ffd_sync
        port (ck, srst, d : in bit; q : out bit);
    end component;

    -- Señales para conectar la lógica del habilitador (Enable)
    signal d_con_enable : bit_vector(n-1 downto 0);
begin

    -- Generamos 'n' flip-flops en paralelo
    reg_paralelo: for i in 0 to n-1 generate
        
        -- Lógica del habilitador: 
        -- Si ena='1', el FFD recibe el nuevo dato d(i).
        -- Si ena='0', el FFD recibe su propio valor q(i) para mantenerlo (memoria).
        d_con_enable(i) <= (d(i) and ena) or (q(i) and not ena);

        -- Instanciación de cada bit del registro
        bit_inst: ffd_sync port map (
            ck   => clk,
            srst => rst,
            d    => d_con_enable(i),
            q    => q(i)
        );
    end generate;

end estructural;