entity tb_mux_4bit is
end tb_mux_4bit;

architecture sim of tb_mux_4bit is

    signal a    : bit_vector(0 to 3) := "0000";
    signal b    : bit_vector(0 to 3) := "0000";
    signal s    : bit := '0';

    signal y    : bit_vector(0 to 3);

begin

    uut : entity work.mux
    port map(
        a => a,
        b => b,
        s => s,
        y => y
    );

    process
    begin

        a <= "0000";
        b <= "0000"; 
        s <= '0';
        wait for 10 ns;

        a <= "1111"; 
        b <= "0000"; 
        s <= '1';
        wait for 10 ns;

        a <= "0000"; 
        b <= "1111";
        s <= '0';
        wait for 10 ns;

        a <= "1111";
        b <= "1111"; 
        s <= '1';
        wait for 10 ns;

        a <= "0001"; 
        b <= "1000"; 
        s <= '0';
        wait for 10 ns;

        a <= "1000"; 
        b <= "0001"; 
        s <= '1';
        wait for 10 ns;

        a <= "1000"; 
        b <= "1000"; 
        s <= '0';
        wait for 10 ns;

        a <= "0001"; 
        b <= "0001"; 
        s <= '1';
        wait for 10 ns;

        wait;

    end process;

end sim;