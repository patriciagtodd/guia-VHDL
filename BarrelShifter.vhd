entity BarrelShifter is
    generic(N : integer := 8);
    port(
        a : in  bit_vector(0 to N-1);
        s : in  bit_vector(0 to 2);
        y : out bit_vector(0 to N-1)
    );
end BarrelShifter;

architecture estructural of BarrelShifter is

    component muxNbit
        generic(N : integer := 8);
        port(
            a : in  bit_vector(0 to N-1);
            b : in  bit_vector(0 to N-1);
            s : in  bit;
            y : out bit_vector(0 to N-1)
        );
    end component;

    --- genero vectores auxiliares para los multiplexores
    signal t1, t2 : bit_vector(0 to N-1); -- resultado de cada mux

    signal sh1 : bit_vector(0 to N-1);
    signal sh2 : bit_vector(0 to N-1);
    signal sh4 : bit_vector(0 to N-1);

begin

    
    -- Vector desplazado 1 posición
    sh1(0 to N-2) <= a(1 to N-1);
    sh1(N-1)      <= '0';
    
    -----------------------------------------------------------------
    -- Un shift: solo si s(0)=1
    -----------------------------------------------------------------
    Mx1 : muxNbit
        generic map(N)
        port map(
            a => a,
            b => sh1,
            s => s(0),
            y => t1
        );

    -- Vector desplazado 2 posiciones
    sh2(0 to N-3) <= t1(2 to N-1);
    sh2(N-2)      <= '0';
    sh2(N-1)      <= '0';
    -----------------------------------------------------------------
    -- Dos shifts: solo si s(1)=1
    -----------------------------------------------------------------
    Mx2 : muxNbit
        generic map(N)
        port map(
            a => t1,
            b => sh2,
            s => s(1),
            y => t2
        );

    -- Vector desplazado 4 posiciones
    sh4(0 to N-5) <= t2(4 to N-1);

    sh4(N-4) <= '0';
    sh4(N-3) <= '0';
    sh4(N-2) <= '0';
    sh4(N-1) <= '0';
    -----------------------------------------------------------------
    -- 4 shifts: solo si s(2)=1
    -----------------------------------------------------------------
    Mx3 : muxNbit
        generic map(N)
        port map(
            a => t2,
            b => sh4,
            s => s(2),
            y => y
        );

end estructural;