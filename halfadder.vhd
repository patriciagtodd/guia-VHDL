entity halfadder is
    port(
        a : in bit;
        b : in bit;
        s : out bit;
        c : out bit
    );
end halfadder;

architecture beh of halfadder is
begin

    s <= a xor b;
    c <= a and b;

end beh;
