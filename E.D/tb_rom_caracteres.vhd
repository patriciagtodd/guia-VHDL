entity tb_rom_caracteres is
end tb_rom_caracteres;


architecture simulacion of tb_rom_caracteres is

    signal caracter_sel : bit_vector(3 downto 0);
    signal row_addr     : bit_vector(2 downto 0);
    signal col_addr     : bit_vector(2 downto 0);
    signal pixel_on     : bit;

begin

    ----------------------------------------------------------------
    -- DUT
    ----------------------------------------------------------------

    DUT : entity work.rom_caracteres
        port map(
            caracter_sel => caracter_sel,
            row_addr     => row_addr,
            col_addr     => col_addr,
            pixel_on     => pixel_on
        );


    ----------------------------------------------------------------
    -- ESTIMULOS
    ----------------------------------------------------------------

    process
    begin

        -- Recorremos los 12 caracteres:
        -- 0000 = 0
        -- 0001 = 1
        -- ...
        -- 1001 = 9
        -- 1010 = .
        -- 1011 = V

        for c in 0 to 11 loop

            if c = 0 then
                caracter_sel <= "0000";
            elsif c = 1 then
                caracter_sel <= "0001";
            elsif c = 2 then
                caracter_sel <= "0010";
            elsif c = 3 then
                caracter_sel <= "0011";
            elsif c = 4 then
                caracter_sel <= "0100";
            elsif c = 5 then
                caracter_sel <= "0101";
            elsif c = 6 then
                caracter_sel <= "0110";
            elsif c = 7 then
                caracter_sel <= "0111";
            elsif c = 8 then
                caracter_sel <= "1000";
            elsif c = 9 then
                caracter_sel <= "1001";
            elsif c = 10 then
                caracter_sel <= "1010";
            else
                caracter_sel <= "1011";
            end if;

            for r in 0 to 7 loop

                if r = 0 then
                    row_addr <= "000";
                elsif r = 1 then
                    row_addr <= "001";
                elsif r = 2 then
                    row_addr <= "010";
                elsif r = 3 then
                    row_addr <= "011";
                elsif r = 4 then
                    row_addr <= "100";
                elsif r = 5 then
                    row_addr <= "101";
                elsif r = 6 then
                    row_addr <= "110";
                else
                    row_addr <= "111";
                end if;

                for col in 0 to 7 loop

                    if col = 0 then
                        col_addr <= "000";
                    elsif col = 1 then
                        col_addr <= "001";
                    elsif col = 2 then
                        col_addr <= "010";
                    elsif col = 3 then
                        col_addr <= "011";
                    elsif col = 4 then
                        col_addr <= "100";
                    elsif col = 5 then
                        col_addr <= "101";
                    elsif col = 6 then
                        col_addr <= "110";
                    else
                        col_addr <= "111";
                    end if;

                    wait for 10 ns;

                end loop;

            end loop;

        end loop;

        wait;

    end process;

end simulacion;