entity adderN is
    generic(
        N : integer := 4
    );
    port(
        A    : in  bit_vector(0 to N-1);
        B    : in  bit_vector(0 to N-1);
        SUB  : in  bit;     -- 0=suma, 1=resta
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

    signal c  : bit_vector(0 to N);
    signal Bx : bit_vector(0 to N-1);

begin

    -- Si SUB=0 → Bx=B
    -- Si SUB=1 → Bx=NOT(B)
    gen_xor : for i in 0 to N-1 generate
    begin
        Bx(i) <= B(i) xor SUB;
    end generate;

    -- Carry inicial
    c(0) <= SUB;

    gen_adders : for i in 0 to N-1 generate
    begin

        FA : fulladder
        port map(
            a    => A(i),
            b    => Bx(i),
            cin  => c(i),
            s    => S(i),
            cout => c(i+1)
        );

    end generate;

    Cout <= c(N);

end estructural;