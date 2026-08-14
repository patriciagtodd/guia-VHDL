entity selector_caracter is
    port (
        fila         : in  bit_vector(2 downto 0);
        columna      : in  bit_vector(2 downto 0);

        unidad_m1, decima_m1, centesima_m1 : in bit_vector(3 downto 0);
        unidad_m2, decima_m2, centesima_m2 : in bit_vector(3 downto 0);
        unidad_m3, decima_m3, centesima_m3 : in bit_vector(3 downto 0);

        caracter_sel : out bit_vector(3 downto 0)
    );
end selector_caracter;

architecture estructural of selector_caracter is
    constant PUNTO   : bit_vector(3 downto 0) := "1010";
    constant VOLT    : bit_vector(3 downto 0) := "1011";
    constant ESPACIO : bit_vector(3 downto 0) := "1100";

    signal m1_01, m1_23, m1_45, m1_67, m1_0123, m1_4567, fila_m1 : bit_vector(3 downto 0);
    signal m2_01, m2_23, m2_45, m2_67, m2_0123, m2_4567, fila_m2 : bit_vector(3 downto 0);
    signal m3_01, m3_23, m3_45, m3_67, m3_0123, m3_4567, fila_m3 : bit_vector(3 downto 0);

    signal r01, r23, r45, r67, r0123, r4567 : bit_vector(3 downto 0);
begin

    ------------------------------------------------------------------
    -- Medicion 1 (F1): elige el caracter segun "columna" (0..4 -> C1..C5)
    ------------------------------------------------------------------
    m1_01i: entity work.muxNbit generic map(N=>4)
        port map(unidad_m1, PUNTO, columna(0), m1_01);
    m1_23i: entity work.muxNbit generic map(N=>4)
        port map(decima_m1, centesima_m1, columna(0), m1_23);
    m1_45i: entity work.muxNbit generic map(N=>4)
        port map(VOLT, ESPACIO, columna(0), m1_45);
    m1_67i: entity work.muxNbit generic map(N=>4)
        port map(ESPACIO, ESPACIO, columna(0), m1_67);

    m1_0123i: entity work.muxNbit generic map(N=>4)
        port map(m1_01, m1_23, columna(1), m1_0123);
    m1_4567i: entity work.muxNbit generic map(N=>4)
        port map(m1_45, m1_67, columna(1), m1_4567);

    m1_finali: entity work.muxNbit generic map(N=>4)
        port map(m1_0123, m1_4567, columna(2), fila_m1);

    ------------------------------------------------------------------
    -- Medicion 2 (F2)
    ------------------------------------------------------------------
    m2_01i: entity work.muxNbit generic map(N=>4)
        port map(unidad_m2, PUNTO, columna(0), m2_01);
    m2_23i: entity work.muxNbit generic map(N=>4)
        port map(decima_m2, centesima_m2, columna(0), m2_23);
    m2_45i: entity work.muxNbit generic map(N=>4)
        port map(VOLT, ESPACIO, columna(0), m2_45);
    m2_67i: entity work.muxNbit generic map(N=>4)
        port map(ESPACIO, ESPACIO, columna(0), m2_67);

    m2_0123i: entity work.muxNbit generic map(N=>4)
        port map(m2_01, m2_23, columna(1), m2_0123);
    m2_4567i: entity work.muxNbit generic map(N=>4)
        port map(m2_45, m2_67, columna(1), m2_4567);

    m2_finali: entity work.muxNbit generic map(N=>4)
        port map(m2_0123, m2_4567, columna(2), fila_m2);

    ------------------------------------------------------------------
    -- Medicion 3 (F3)
    ------------------------------------------------------------------
    m3_01i: entity work.muxNbit generic map(N=>4)
        port map(unidad_m3, PUNTO, columna(0), m3_01);
    m3_23i: entity work.muxNbit generic map(N=>4)
        port map(decima_m3, centesima_m3, columna(0), m3_23);
    m3_45i: entity work.muxNbit generic map(N=>4)
        port map(VOLT, ESPACIO, columna(0), m3_45);
    m3_67i: entity work.muxNbit generic map(N=>4)
        port map(ESPACIO, ESPACIO, columna(0), m3_67);

    m3_0123i: entity work.muxNbit generic map(N=>4)
        port map(m3_01, m3_23, columna(1), m3_0123);
    m3_4567i: entity work.muxNbit generic map(N=>4)
        port map(m3_45, m3_67, columna(1), m3_4567);

    m3_finali: entity work.muxNbit generic map(N=>4)
        port map(m3_0123, m3_4567, columna(2), fila_m3);

    ------------------------------------------------------------------
    -- Eleccion final: cual de las 3 mediciones, segun "fila"
    ------------------------------------------------------------------
    mr_01: entity work.muxNbit generic map(N=>4)
        port map(fila_m1, fila_m2, fila(0), r01);
    mr_23: entity work.muxNbit generic map(N=>4)
        port map(fila_m3, ESPACIO, fila(0), r23);
    mr_45: entity work.muxNbit generic map(N=>4)
        port map(ESPACIO, ESPACIO, fila(0), r45);
    mr_67: entity work.muxNbit generic map(N=>4)
        port map(ESPACIO, ESPACIO, fila(0), r67);

    mr_0123: entity work.muxNbit generic map(N=>4)
        port map(r01, r23, fila(1), r0123);
    mr_4567: entity work.muxNbit generic map(N=>4)
        port map(r45, r67, fila(1), r4567);

    mr_final: entity work.muxNbit generic map(N=>4)
        port map(r0123, r4567, fila(2), caracter_sel);

end estructural;