entity tb_sum_restN is
end;

architecture sim of tb_sum_restN is

    signal A    : bit_vector(0 to 3);
    signal B    : bit_vector(0 to 3);
    signal S    : bit_vector(0 to 3);
    signal SUB  : bit;     -- 0=suma, 1=resta
    signal Cout : bit;

begin

    uut : entity work.FHadderN
    generic map(
        N => 4
    )
    port map(
        A => A,
        B => B,
        SUB => SUB,
        S => S,
        Cout => Cout
    );

    process
    begin

        A <= "0000";
        B <= "0000";
        SUB <= '0';  -- suma 
        wait for 10 ns;

        A <= "0101";
        B <= "0011";
        SUB <= '1';  -- resta
        wait for 10 ns;

        A <= "1111";
        B <= "0001";
        SUB <= '1';  --resta
        wait for 10 ns;

        wait;

    end process;

end sim;