entity ffd is
port (
clr : in bit ;
clk : in bit ;
d : in bit ;
q : out bit ) ;
end ;

architecture behavior of ffd is
begin
process( clk, clr)
    begin
        if (clr = '1') then
            q <= '0' ;
        elsif (clk'event and clk = '1') then
            q <= d ;
        end if ;
    end process ;

end behavior; 






