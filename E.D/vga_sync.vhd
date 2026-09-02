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
    component con_gen
        generic (n : integer := 4);
        port (clk, rst : in bit; q : out bit_vector(n-1 downto 0));
    end component;

    component contador_habilitado
        generic (n : integer := 4);
        port (clk, rst, habilita : in bit; q : buffer bit_vector(n-1 downto 0));
    end component;

    signal q_h, q_v : bit_vector(9 downto 0);
    signal h_rst_internal, v_rst_internal : bit;
    signal end_of_line : bit;
begin
    -- 1. Contador Horizontal
    h_rst_internal <= rst_global or (q_h(9) and q_h(8) and not q_h(7) and not q_h(6) and not q_h(5) and q_h(4) and q_h(3) and q_h(2) and q_h(1) and q_h(0));

    h_cont: con_gen
        generic map (n => 10)
        port map (clk => clk_25MHz, rst => h_rst_internal, q => q_h);

    -- 2. Contador Vertical
    -- Mismo reloj que el horizontal; end_of_line habilita el avance en vez de clockear
    end_of_line <= (q_h(9) and q_h(8) and not q_h(7) and not q_h(6) and not q_h(5) and q_h(4) and q_h(3) and q_h(2) and q_h(1) and q_h(0));
    v_rst_internal <= rst_global or (q_v(9) and q_v(3) and q_v(2) and q_v(0));

    v_cont: contador_habilitado
        generic map (n => 10)
        port map (clk => clk_25MHz, rst => v_rst_internal, habilita => end_of_line, q => q_v);

    -- 3. Señal de Video ON
    video_on <= not ( q_h(9) and (q_h(8) or q_h(7)) )
            and
            not ( q_v(9) or (q_v(8) and q_v(7) and q_v(6) and q_v(5)) );

    pixel_x <= q_h;
    pixel_y <= q_v;
end estructural;