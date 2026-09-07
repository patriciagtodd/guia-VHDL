entity tb_pantalla_ascii is
end tb_pantalla_ascii;

architecture sim of tb_pantalla_ascii is

    signal fila, columna       : bit_vector(2 downto 0);
    signal row_addr, col_addr  : bit_vector(2 downto 0);
    signal caracter_sel        : bit_vector(3 downto 0);
    signal pixel_on            : bit;

    -- Digitos de ejemplo para ver algo con sentido: 5.23V, 9.99V, 0.01V
    signal unidad_m1 : bit_vector(3 downto 0) := "0101"; -- 5
    signal decima_m1 : bit_vector(3 downto 0) := "0010"; -- 2
    signal centesima_m1 : bit_vector(3 downto 0) := "0011"; -- 3

    signal unidad_m2 : bit_vector(3 downto 0) := "1001"; -- 9
    signal decima_m2 : bit_vector(3 downto 0) := "1001"; -- 9
    signal centesima_m2 : bit_vector(3 downto 0) := "1001"; -- 9

    signal unidad_m3 : bit_vector(3 downto 0) := "0000"; -- 0
    signal decima_m3 : bit_vector(3 downto 0) := "0000"; -- 0
    signal centesima_m3 : bit_vector(3 downto 0) := "0001"; -- 1

begin

    U_SEL : entity work.selector_caracter
        port map (
            fila => fila, columna => columna,
            unidad_m1 => unidad_m1, decima_m1 => decima_m1, centesima_m1 => centesima_m1,
            unidad_m2 => unidad_m2, decima_m2 => decima_m2, centesima_m2 => centesima_m2,
            unidad_m3 => unidad_m3, decima_m3 => decima_m3, centesima_m3 => centesima_m3,
            caracter_sel => caracter_sel
        );

    U_ROM : entity work.rom_caracteres
        port map (
            caracter_sel => caracter_sel,
            row_addr => row_addr,
            col_addr => col_addr,
            pixel_on => pixel_on
        );

    process
        variable linea : string(1 to 40);
    begin
        for f in 0 to 2 loop  -- F1, F2, F3

            if f = 0 then fila <= "000";
            elsif f = 1 then fila <= "001";
            else fila <= "010";
            end if;

            for r in 0 to 7 loop  -- fila de pixeles de la fuente

                if r = 0 then row_addr <= "000";
                elsif r = 1 then row_addr <= "001";
                elsif r = 2 then row_addr <= "010";
                elsif r = 3 then row_addr <= "011";
                elsif r = 4 then row_addr <= "100";
                elsif r = 5 then row_addr <= "101";
                elsif r = 6 then row_addr <= "110";
                else row_addr <= "111";
                end if;

                for c in 0 to 4 loop  -- C1..C5

                    if c = 0 then columna <= "000";
                    elsif c = 1 then columna <= "001";
                    elsif c = 2 then columna <= "010";
                    elsif c = 3 then columna <= "011";
                    else columna <= "100";
                    end if;

                    for col in 0 to 7 loop  -- columna de pixeles de la fuente

                        if col = 0 then col_addr <= "000";
                        elsif col = 1 then col_addr <= "001";
                        elsif col = 2 then col_addr <= "010";
                        elsif col = 3 then col_addr <= "011";
                        elsif col = 4 then col_addr <= "100";
                        elsif col = 5 then col_addr <= "101";
                        elsif col = 6 then col_addr <= "110";
                        else col_addr <= "111";
                        end if;

                        wait for 1 ns;  -- deja asentar la logica combinacional

                        if pixel_on = '1' then
                            linea(c*8 + col + 1) := '#';
                        else
                            linea(c*8 + col + 1) := '.';
                        end if;

                    end loop;
                end loop;

                report linea;

            end loop;
        end loop;

        wait;
    end process;

end sim;