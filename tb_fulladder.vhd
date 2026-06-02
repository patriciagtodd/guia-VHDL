entity tb_fulladder is
end tb_fulladder;

architecture sim of tb_fulladder is

    signal a    : bit := '0';
    signal b    : bit := '0';
    signal cin  : bit := '0';

    signal s    : bit;
    signal cout : bit;

begin

    uut : entity work.fulladder
    port map(
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    process
    begin

        a <= '0'; b <= '0'; cin <= '0';
        wait for 10 ns;

        a <= '0'; b <= '0'; cin <= '1';
        wait for 10 ns;

        a <= '0'; b <= '1'; cin <= '0';
        wait for 10 ns;

        a <= '0'; b <= '1'; cin <= '1';
        wait for 10 ns;

        a <= '1'; b <= '0'; cin <= '0';
        wait for 10 ns;

        a <= '1'; b <= '0'; cin <= '1';
        wait for 10 ns;

        a <= '1'; b <= '1'; cin <= '0';
        wait for 10 ns;

        a <= '1'; b <= '1'; cin <= '1';
        wait for 10 ns;

        wait;

    end process;

end sim;