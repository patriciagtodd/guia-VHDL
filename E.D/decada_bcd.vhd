entity decada_bcd is
    port (
        clk       : in  bit;
        rst       : in  bit;               -- reset sincronico externo (fuerza a 0000)
        habilita  : in  bit;               -- '1' = este digito cuenta en este flanco
        q         : buffer bit_vector(3 downto 0);  -- digito BCD actual (0-9)
        carry_out : out bit                -- pulso: va a pasar de 9 a 0 en el proximo flanco
    );
end decada_bcd;

architecture estructural of decada_bcd is
    component ffd_sync is
        port (ck, srst, d : in bit; q : out bit);
    end component;

    signal d_inputs     : bit_vector(3 downto 0);
    signal carry        : bit_vector(4 downto 0);
    signal es_nueve     : bit;
    signal reset_decada : bit;
begin
    -- Detecta "9" (1001), igual tecnica que en con_dec.vhd
    es_nueve <= q(3) and not q(2) and not q(1) and q(0);

    -- Se resetea con el reset externo, o solo al pasar de 9 a 0
    reset_decada <= rst or (es_nueve and habilita);

    -- El "permiso para cambiar" del bit 0 ahora es el habilitador,
    -- no una constante '1' como en con_dec
    carry(0) <= habilita;

    gen_cont: for i in 0 to 3 generate
        ff_inst: ffd_sync port map (
            ck   => clk,
            srst => reset_decada,
            d    => d_inputs(i),
            q    => q(i)
        );
        d_inputs(i) <= q(i) xor carry(i);
        carry(i+1)  <= carry(i) and q(i);
    end generate;

    carry_out <= es_nueve and habilita;

end estructural;