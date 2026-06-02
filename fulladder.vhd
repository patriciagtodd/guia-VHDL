entity fulladder is
    port(
        a    : in bit;
        b    : in bit;
        cin  : in bit;
        s    : out bit;
        cout : out bit
    );
end fulladder;

architecture estructural of fulladder is

    component halfadder
        port(
            a : in bit;
            b : in bit;
            s : out bit;
            c : out bit
        );
    end component;

    signal s1 : bit;
    signal c1 : bit;
    signal c2 : bit;

begin

    HA1 : halfadder
        port map(
            a => a,
            b => b,
            s => s1,
            c => c1
        );

    HA2 : halfadder
        port map(
            a => s1,
            b => cin,
            s => s,
            c => c2
        );

    cout <= c1 or c2;

end estructural;