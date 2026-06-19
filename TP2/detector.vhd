entity detector_110 is 
    port ( 
        clk: in bit;
        reset: in bit;
        X : in bit;
        S : out bit );
end detector_110;

architecture estructural of detector_110 is 
    component ffd port (
        clr: in bit;
        clk: in bit;
        d : in bit;
        q : out bit);
        end component;

    signal q1, q0, d1, d0 : bit;

begin
    d1 <= (q1 and not q0) or (X and not q1 and q0);
    
    d0 <= (X and not q1 and not q0) or (X and q1 and q0) or (not X and q1 and not q0);

    --FFD
    FF1: ffd port map (reset, clk, d1, q1);
    FF0: ffd port map (reset, clk, d0, q0);


    S <= q1 and q0;
end estructural;