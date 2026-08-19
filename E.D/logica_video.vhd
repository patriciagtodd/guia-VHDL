entity logica_video is
    port (
        clk_25MHz    : in  bit;
        rst_global   : in  bit;

        unidad_m1, decima_m1, centesima_m1 : in bit_vector(3 downto 0);
        unidad_m2, decima_m2, centesima_m2 : in bit_vector(3 downto 0);
        unidad_m3, decima_m3, centesima_m3 : in bit_vector(3 downto 0);

        h_sync       : out bit;
        v_sync       : out bit;
        video_pixel  : out bit;
        pixel_x_dbg  : out bit_vector(9 downto 0);
        pixel_y_dbg  : out bit_vector(9 downto 0)
    );
end logica_video;

architecture estructural of logica_video is

    signal px, py              : bit_vector(9 downto 0);
    signal video_on_vga        : bit;
    signal columna, fila       : bit_vector(2 downto 0);
    signal col_addr, row_addr  : bit_vector(2 downto 0);
    signal en_zona             : bit;
    signal caracter_sel        : bit_vector(3 downto 0);
    signal pixel_on            : bit;

begin

    U_VGA : entity work.vga_sync
        port map (clk_25MHz => clk_25MHz, rst_global => rst_global,
                   h_sync => h_sync, v_sync => v_sync, video_on => video_on_vga,
                   pixel_x => px, pixel_y => py);

    U_DECOD : entity work.decod_posicion
        port map (pixel_x => px, pixel_y => py,
                   columna => columna, fila => fila,
                   col_addr => col_addr, row_addr => row_addr,
                   en_zona => en_zona);

    U_SEL : entity work.selector_caracter
        port map (fila => fila, columna => columna,
                   unidad_m1 => unidad_m1, decima_m1 => decima_m1, centesima_m1 => centesima_m1,
                   unidad_m2 => unidad_m2, decima_m2 => decima_m2, centesima_m2 => centesima_m2,
                   unidad_m3 => unidad_m3, decima_m3 => decima_m3, centesima_m3 => centesima_m3,
                   caracter_sel => caracter_sel);

    U_ROM : entity work.rom_caracteres
        port map (caracter_sel => caracter_sel, row_addr => row_addr,
                   col_addr => col_addr, pixel_on => pixel_on);

    video_pixel <= video_on_vga and en_zona and pixel_on;

    pixel_x_dbg <= px;
    pixel_y_dbg <= py;

end estructural;