entity tb_adderN is
end;

architecture sim of tb_adderN is

    signal A    : bit_vector(0 to 3);
    signal B    : bit_vector(0 to 3);
    signal S    : bit_vector(0 to 3);
    signal Cout : bit;

begin

    uut : entity work.adderN
    generic map(
        N => 4
    )
    port map(
        A => A,
        B => B,
        S => S,
        Cout => Cout
    );

    process
    begin

        A <= "0000";
        B <= "0000";
        wait for 10 ns;

        A <= "0101";
        B <= "0011";
        wait for 10 ns;

        A <= "1111";
        B <= "0001";
        wait for 10 ns;

        wait;

    end process;

end sim;