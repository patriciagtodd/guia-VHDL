entity mux is
    port(
        a : in bit_vector(0 to 3);
        b : in bit_vector(0 to 3);
        s : in bit;
        y : out bit_vector(0 to 3)
    );
end mux;

architecture selec of mux is
begin
    gen_mux : for i in 0 to 3 generate
        y(i) <= (a(i) and (not s)) or (b(i) and s);
    end generate;

end selec;