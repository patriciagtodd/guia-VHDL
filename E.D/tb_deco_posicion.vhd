entity tb_decod_posicion is
end tb_decod_posicion;

architecture sim of tb_decod_posicion is

    signal pixel_x : bit_vector(9 downto 0);
    signal pixel_y : bit_vector(9 downto 0);

    signal columna, fila       : bit_vector(2 downto 0);
    signal col_addr, row_addr  : bit_vector(2 downto 0);
    signal en_zona             : bit;

begin

    DUT : entity work.decod_posicion
        port map (
            pixel_x  => pixel_x,
            pixel_y  => pixel_y,
            columna  => columna,
            fila     => fila,
            col_addr => col_addr,
            row_addr => row_addr,
            en_zona  => en_zona
        );

    process
    begin

        -- (0,0) -> F1, C1, fuente(0,0), dentro de zona
        pixel_x <= "0000000000";  -- 0
        pixel_y <= "0000000000";  -- 0
        wait for 10 ns;

        -- (7,7) -> mismo pixel de fuente que (0,0), todavia dentro del bloque 8x8
        pixel_x <= "0000000111";  -- 7
        pixel_y <= "0000000111";  -- 7
        wait for 10 ns;

        -- (8,0) -> siguiente pixel de fuente dentro del mismo caracter (col_addr=1)
        pixel_x <= "0000001000";  -- 8
        pixel_y <= "0000000000";
        wait for 10 ns;

        -- (63,0) -> ultimo pixel de fuente del caracter C1 (col_addr=7)
        pixel_x <= "0000111111";  -- 63
        pixel_y <= "0000000000";
        wait for 10 ns;

        -- (64,0) -> primer pixel del caracter C2 (columna=1, col_addr=0)
        pixel_x <= "0001000000";  -- 64
        pixel_y <= "0000000000";
        wait for 10 ns;

        -- (0,64) -> primer pixel de la fila F2 (fila=1)
        pixel_x <= "0000000000";
        pixel_y <= "0001000000";  -- 64
        wait for 10 ns;

        -- (319,0) -> ultimo pixel de C5 (columna=4), todavia dentro de zona
        pixel_x <= "0100111111";  -- 319
        pixel_y <= "0000000000";
        wait for 10 ns;

        -- (320,0) -> ya se salio de la zona de texto (columna=5)
        pixel_x <= "0101000000";  -- 320
        pixel_y <= "0000000000";
        wait for 10 ns;

        -- (0,191) -> ultimo pixel de F3, todavia dentro de zona
        pixel_x <= "0000000000";
        pixel_y <= "0010111111";  -- 191
        wait for 10 ns;

        -- (0,192) -> se salio de la zona de texto (fila=3)
        pixel_x <= "0000000000";
        pixel_y <= "0011000000";  -- 192
        wait for 10 ns;

        wait;

    end process;

end sim;