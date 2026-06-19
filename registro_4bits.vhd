entity registro_4bits_en_ff is 
    port ( clr, ck, d : in bit; q : out bit );
end registro_4bits_en_ff;

architecture beh of registro_4bits_en_ff is 
begin
    process(ck, clr) begin
        if clr = '1' then q <= '0';
        elsif ck = '1' and ck'event then q <= d;
        end if;
    end process;
end beh;