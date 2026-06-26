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

    signal q_h, q_v : bit_vector(9 downto 0);
    signal h_rst_internal, v_rst_internal : bit;
    signal end_of_line : bit;
begin
    -- 1. Contador Horizontal
    -- Se resetea con el reset global o cuando llega a 800
    h_rst_internal <= rst_global or (q_h(9) and q_h(8) and q_h(5));
    
    h_cont: con_gen 
        generic map (n => 10)
        port map (clk => clk_25MHz, rst => h_rst_internal, q => q_h);

    -- 2. Contador Vertical
    -- Incrementa solo cuando termina una línea horizontal
    end_of_line <= q_h(9) and q_h(8) and q_h(5); 
    v_rst_internal <= rst_global or (q_v(9) and q_v(3) and q_v(2) and q_v(0));

    v_cont: con_gen 
        generic map (n => 10)
        port map (clk => end_of_line, rst => v_rst_internal, q => q_v);

    -- 3. Lógica de Salida Sincronismo (Simplificada para ejemplo)
    -- h_sync debe ser '0' en el rango 656-751.
    -- Implementar mediante decodificadores de puertas según el valor de q_h.
    
    -- Señal de Video ON (Solo cuando ambos están en área visible)
    -- Visible si q_h < 640 (bit 9 o 8 son 0) y q_v < 480
    video_on <= not ( q_h(9) and (q_h(8) or q_h(7)) ) -- H < 640
            and 
            not ( q_v(9) or (q_v(8) and q_v(7) and q_v(6) and q_v(5)) ); -- V < 480

    pixel_x <= q_h;
    pixel_y <= q_v;
end estructural;