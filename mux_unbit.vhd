entity mux is
    port(
        a : in bit;
        b : in bit;
        s : in bit;
        c : out bit
    );
end mux;

architecture selec of mux is
begin

    c <= (a and (not s)) or (b and s);

end selec;