entity adderN is                   -- defino generico
    generic(N : integer := 4);
    port(
        A    : in  bit_vector(0 to N-1);
        B    : in  bit_vector(0 to N-1);
        S    : out bit_vector(0 to N-1);
        Cout : out bit
    );
end adderN;

architecture estructural of adderN is

    component fulladder
        port(
            a    : in bit;
            b    : in bit;
            cin  : in bit;
            s    : out bit;
            cout : out bit
        );
    end component;

    signal c : bit_vector(0 to N);
begin 
    gen_adders : for i in 0 to N-1 generate
        FA : fulladder
            port map(
                a => A(i),
                b => B(i),
                cin => c(i),
                s => S(i),
                cout => c(i+1)
            );
    end generate;

    c(0) <= '0';
    Cout <= c(N);

end estructural;