entity mux is
    port(
        a : in bit;
        b : in bit;
        s : in bit;
        y : out bit
    );
end mux;

architecture selec of mux is
begin

    y <= (a and (not s)) or (b and s);

end selec;