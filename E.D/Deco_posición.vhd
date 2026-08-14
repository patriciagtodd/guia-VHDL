entity decod_posicion is
    port (
        pixel_x  : in  bit_vector(9 downto 0);
        pixel_y  : in  bit_vector(9 downto 0);

        columna  : out bit_vector(2 downto 0);
        fila     : out bit_vector(2 downto 0);
        col_addr : out bit_vector(2 downto 0);
        row_addr : out bit_vector(2 downto 0);
        en_zona  : out bit
    );
end decod_posicion;

architecture rtl of decod_posicion is
    signal col_valida, fila_valida : bit;
begin
    -- Direccion dentro del caracter (fuente 8x8) -- solo "cortar" bits
    col_addr <= pixel_x(5 downto 3);
    row_addr <= pixel_y(5 downto 3);

    -- Indice de caracter en la grilla de texto -- solo "cortar" bits
    columna <= pixel_x(8 downto 6);
    fila    <= pixel_y(8 downto 6);

    -- columna < 5  (evita los patrones 101, 110, 111)
    col_valida  <= (not pixel_x(8)) or ((not pixel_x(7)) and (not pixel_x(6)));

    -- fila < 3  (evita los patrones 011, 100, 101, 110, 111)
    fila_valida <= (not pixel_y(8)) and ((not pixel_y(7)) or (not pixel_y(6)));

    en_zona <= (not pixel_x(9)) and (not pixel_y(9)) and col_valida and fila_valida;

end rtl;