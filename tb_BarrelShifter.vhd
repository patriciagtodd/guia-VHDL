entity tb_BarrelShifter is
end tb_BarrelShifter;

architecture simulacion of tb_BarrelShifter is

    component BarrelShifter
        generic(N : integer := 8);
        port(
            a : in  bit_vector(0 to N-1);
            s : in  bit_vector(0 to 2);
            y : out bit_vector(0 to N-1)
        );
    end component;

    signal a : bit_vector(0 to 7);
    signal s : bit_vector(0 to 2);
    signal y : bit_vector(0 to 7);

begin

    DUT : BarrelShifter
        generic map(
            N => 8
        )
        port map(
            a => a,
            s => s,
            y => y
        );

  process
begin
    -- shift de 1: s = "001"
    a <= "10110011";
    s <= "001";
    wait for 5 ns;
    -- esperado: "01100110"

    -- shift de 2: s = "010"
    a <= "10110011";
    s <= "010";
    wait for 5 ns;
    -- esperado: "00101100" (incorrecto aun... ver abajo)

    -- shift de 3: s = "011"
    a <= "10110011";
    s <= "011";
    wait for 5 ns;
    -- esperado: "10011000"

    -- shift de 4: s = "100"
    a <= "10110011";
    s <= "100";
    wait for 5 ns;
    -- esperado: "00110000"
    
    -- shift de 5: s = "101"
    a <= "10110011";
    s <= "101";
    wait for 5 ns;
    -- esperado: "01100000"
    
     -- shift de 6: s = "110"
    a <= "10110011";
    s <= "110";
    wait for 5 ns;
    -- esperado: "11000000"
    
     -- shift de 7: s = "111"
    a <= "10110011";
    s <= "111";
    wait for 5 ns;
    -- esperado: "10000000"

    wait;
end process;

end simulacion;