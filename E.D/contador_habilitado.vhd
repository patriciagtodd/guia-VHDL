entity contador_habilitado is
    generic (n : integer := 4);
    port (
        clk      : in  bit;
        rst      : in  bit;
        habilita : in  bit;
        q        : buffer bit_vector(n-1 downto 0)
    );
end contador_habilitado;

architecture estructural of contador_habilitado is
    component ffd_sync
        port (ck, srst, d : in bit; q : out bit);
    end component;

    signal d_inputs : bit_vector(n-1 downto 0);
    signal carry    : bit_vector(n downto 0);
begin
    carry(0) <= habilita;  -- unica diferencia respecto a con_gen: aca no es '1' fijo

    gen_cont: for i in 0 to n-1 generate
        ff_inst: ffd_sync port map (ck => clk, srst => rst, d => d_inputs(i), q => q(i));
        d_inputs(i) <= q(i) xor carry(i);
        carry(i+1)  <= carry(i) and q(i);
    end generate;
end estructural;