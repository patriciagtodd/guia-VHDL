entity vga_sync is
    port (
        clk_25MHz : in  bit;
        rst_global: in  bit;
        h_sync    : out bit;
        v_sync    : out bit;
        video_on  : out bit;
        pixel_x   : out bit_vector(9 downto 0);
        pixel_y   : out bit_vector(9 downto 0)
    );
end vga_sync;


architecture estructural of vga_sync is

    component contador_habilitado
        generic (n : integer := 4);
        port (
            clk      : in  bit;
            rst      : in  bit;
            habilita : in  bit;
            q        : buffer bit_vector(n-1 downto 0)
        );
    end component;


    signal q_h, q_v : bit_vector(9 downto 0);

    signal h_rst_internal : bit;
    signal v_rst_internal : bit;

    signal end_of_line : bit;

    signal common_h : bit;
    signal h_sync_n : bit;
    signal v_sync_n : bit;


begin

    -- =========================================================
    -- CONTADOR HORIZONTAL
    -- Cuenta permanentemente con el reloj de 25 MHz

    -- FIN DE LINEA -----> q_h = 799
    -- =========================================================

    end_of_line <=
        (q_h(9) and q_h(8) and not q_h(7) and not q_h(6) and not q_h(5)
         and q_h(4) and q_h(3) and q_h(2) and q_h(1) and q_h(0));


    h_rst_internal <= rst_global or end_of_line;

    h_cont: contador_habilitado
        generic map (n => 10)
        port map (
            clk      => clk_25MHz,
            rst      => h_rst_internal,
            habilita => '1',
            q        => q_h
        );


    -- =========================================================
    -- CONTADOR VERTICAL
    -- Usa el mismo reloj de 25 MHz.
    -- Solo avanza cuando termina una linea horizontal.
    -- =========================================================

    v_rst_internal <= rst_global or
        (q_v(9) and q_v(3) and q_v(2) and q_v(0));

    v_cont: contador_habilitado
        generic map (n => 10)
        port map (
            clk      => clk_25MHz,
            rst      => v_rst_internal,
            habilita => end_of_line,
            q        => q_v
        );


    -- =========================================================
    -- SINCRONISMO HORIZONTAL
    -- Intervalo: 656 a 751
    -- =========================================================

    common_h <= q_h(9) and not q_h(8) and q_h(7);

    h_sync_n <= common_h and
        ((not q_h(6) and q_h(4)) or
         (not q_h(4) and q_h(5)) or
         (not q_h(5) and q_h(6)));

    h_sync <= not h_sync_n;


    -- =========================================================
    -- SINCRONISMO VERTICAL
    -- Intervalo: 490 a 491
    -- =========================================================

    v_sync_n <= not q_v(9) and q_v(8) and q_v(7) and q_v(6) and q_v(5)
                and not q_v(4) and q_v(3) and not q_v(2) and q_v(1);

    v_sync <= not v_sync_n;


    -- =========================================================
    -- VIDEO ACTIVO
    -- Área visible: 640 x 480
    -- =========================================================

    video_on <= not (q_h(9) and (q_h(8) or q_h(7)))
                and
                not (q_v(9) or
                     (q_v(8) and q_v(7) and q_v(6) and q_v(5)));


    -- =========================================================
    -- COORDENADAS DE PIXEL
    -- =========================================================

    pixel_x <= q_h;
    pixel_y <= q_v;

end estructural;