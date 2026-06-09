entity mux is
    generic(N : integer := 4);
    port(
        a : in bit_vector(0 to N-1);
        b : in bit_vector(0 to N-1);
        s : in bit;
        y : out bit_vector(0 to N-1)
    );
end mux;

architecture selec of mux is
begin
    gen_mux : for i in 0 to N-1 generate
        y(i) <= (a(i) and (not s)) or (b(i) and s);
    end generate;

end selec;