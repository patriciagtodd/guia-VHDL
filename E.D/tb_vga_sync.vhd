entity tb_vga_sync is
end tb_vga_sync;

architecture sim of tb_vga_sync is
    -- 1. Señales de interconexión
    signal clk_25  : bit := '0';
    signal rst     : bit := '0';
    signal hsync   : bit;
    signal vsync   : bit;
    signal v_on    : bit;
    signal px_x    : bit_vector(9 downto 0);
    signal px_y    : bit_vector(9 downto 0);

    -- 2. Declaración del componente a probar
    component vga_sync
        port (
            clk_25MHz : in  bit;
            rst_global: in  bit;
            h_sync    : out bit;
            v_sync    : out bit;
            video_on  : out bit;
            pixel_x   : out bit_vector(9 downto 0);
            pixel_y   : out bit_vector(9 downto 0)
        );
    end component;

begin
    -- 3. Instanciación de la Unidad Bajo Prueba (UUT)
    UUT: vga_sync port map (
        clk_25MHz  => clk_25,
        rst_global => rst,
        h_sync     => hsync,
        v_sync     => vsync,
        video_on   => v_on,
        pixel_x    => px_x,
        pixel_y    => px_y
    );

    -- 4. Generador de Reloj de 25 MHz
    -- El periodo es 40ns (1/25MHz). Cambia cada 20ns.
    clk_25 <= not clk_25 after 20 ns;

    -- 5. Proceso de Estímulos
    process
    begin
        -- Aplicamos reset inicial sincronizado
        rst <= '1';
        wait for 100 ns; 
        rst <= '0';

        -- Dejamos correr la simulación. 
        -- Una línea horizontal completa (800 píxeles) tarda: 
        -- 800 * 40ns = 32.000 ns = 32 us.
        -- Para ver 2 líneas, simulamos 70 us.
        wait for 70 us;

        -- Finalizar simulación
        assert false report "Simulación terminada" severity note;
        wait;
    end process;

end sim;