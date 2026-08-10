
entity rom_caracteres is
    port(
        caracter_sel : in  bit_vector(3 downto 0);
        row_addr     : in  bit_vector(2 downto 0);
        col_addr     : in  bit_vector(2 downto 0);
        pixel_on     : out bit
    );
end rom_caracteres;


architecture estructural of rom_caracteres is

    ----------------------------------------------------------------
    -- FILAS DE LOS CARACTERES
    ----------------------------------------------------------------

    signal c0_f0, c0_f1, c0_f2, c0_f3 : bit_vector(0 to 7);
    signal c0_f4, c0_f5, c0_f6, c0_f7 : bit_vector(0 to 7);

    signal c1_f0, c1_f1, c1_f2, c1_f3 : bit_vector(0 to 7);
    signal c1_f4, c1_f5, c1_f6, c1_f7 : bit_vector(0 to 7);

    signal c2_f0, c2_f1, c2_f2, c2_f3 : bit_vector(0 to 7);
    signal c2_f4, c2_f5, c2_f6, c2_f7 : bit_vector(0 to 7);

    signal c3_f0, c3_f1, c3_f2, c3_f3 : bit_vector(0 to 7);
    signal c3_f4, c3_f5, c3_f6, c3_f7 : bit_vector(0 to 7);

    signal c4_f0, c4_f1, c4_f2, c4_f3 : bit_vector(0 to 7);
    signal c4_f4, c4_f5, c4_f6, c4_f7 : bit_vector(0 to 7);

    signal c5_f0, c5_f1, c5_f2, c5_f3 : bit_vector(0 to 7);
    signal c5_f4, c5_f5, c5_f6, c5_f7 : bit_vector(0 to 7);

    signal c6_f0, c6_f1, c6_f2, c6_f3 : bit_vector(0 to 7);
    signal c6_f4, c6_f5, c6_f6, c6_f7 : bit_vector(0 to 7);

    signal c7_f0, c7_f1, c7_f2, c7_f3 : bit_vector(0 to 7);
    signal c7_f4, c7_f5, c7_f6, c7_f7 : bit_vector(0 to 7);

    signal c8_f0, c8_f1, c8_f2, c8_f3 : bit_vector(0 to 7);
    signal c8_f4, c8_f5, c8_f6, c8_f7 : bit_vector(0 to 7);

    signal c9_f0, c9_f1, c9_f2, c9_f3 : bit_vector(0 to 7);
    signal c9_f4, c9_f5, c9_f6, c9_f7 : bit_vector(0 to 7);

    signal cd_f0, cd_f1, cd_f2, cd_f3 : bit_vector(0 to 7);
    signal cd_f4, cd_f5, cd_f6, cd_f7 : bit_vector(0 to 7);

    signal cV_f0, cV_f1, cV_f2, cV_f3 : bit_vector(0 to 7);
    signal cV_f4, cV_f5, cV_f6, cV_f7 : bit_vector(0 to 7);


    ----------------------------------------------------------------
    -- CARACTERES NO UTILIZADOS = ESPACIO
    ----------------------------------------------------------------

    signal ce0_f0, ce0_f1, ce0_f2, ce0_f3 : bit_vector(0 to 7);
    signal ce0_f4, ce0_f5, ce0_f6, ce0_f7 : bit_vector(0 to 7);

    signal ce1_f0, ce1_f1, ce1_f2, ce1_f3 : bit_vector(0 to 7);
    signal ce1_f4, ce1_f5, ce1_f6, ce1_f7 : bit_vector(0 to 7);

    signal ce2_f0, ce2_f1, ce2_f2, ce2_f3 : bit_vector(0 to 7);
    signal ce2_f4, ce2_f5, ce2_f6, ce2_f7 : bit_vector(0 to 7);

    signal ce3_f0, ce3_f1, ce3_f2, ce3_f3 : bit_vector(0 to 7);
    signal ce3_f4, ce3_f5, ce3_f6, ce3_f7 : bit_vector(0 to 7);


    ----------------------------------------------------------------
    -- FILA SELECCIONADA DE CADA CARACTER
    ----------------------------------------------------------------

    signal fila0_01, fila0_23, fila0_45, fila0_67 : bit_vector(0 to 7);
    signal fila0_0123, fila0_4567, fila0 : bit_vector(0 to 7);

    signal fila1_01, fila1_23, fila1_45, fila1_67 : bit_vector(0 to 7);
    signal fila1_0123, fila1_4567, fila1 : bit_vector(0 to 7);

    signal fila2_01, fila2_23, fila2_45, fila2_67 : bit_vector(0 to 7);
    signal fila2_0123, fila2_4567, fila2 : bit_vector(0 to 7);

    signal fila3_01, fila3_23, fila3_45, fila3_67 : bit_vector(0 to 7);
    signal fila3_0123, fila3_4567, fila3 : bit_vector(0 to 7);

    signal fila4_01, fila4_23, fila4_45, fila4_67 : bit_vector(0 to 7);
    signal fila4_0123, fila4_4567, fila4 : bit_vector(0 to 7);

    signal fila5_01, fila5_23, fila5_45, fila5_67 : bit_vector(0 to 7);
    signal fila5_0123, fila5_4567, fila5 : bit_vector(0 to 7);

    signal fila6_01, fila6_23, fila6_45, fila6_67 : bit_vector(0 to 7);
    signal fila6_0123, fila6_4567, fila6 : bit_vector(0 to 7);

    signal fila7_01, fila7_23, fila7_45, fila7_67 : bit_vector(0 to 7);
    signal fila7_0123, fila7_4567, fila7 : bit_vector(0 to 7);

    signal fila8_01, fila8_23, fila8_45, fila8_67 : bit_vector(0 to 7);
    signal fila8_0123, fila8_4567, fila8 : bit_vector(0 to 7);

    signal fila9_01, fila9_23, fila9_45, fila9_67 : bit_vector(0 to 7);
    signal fila9_0123, fila9_4567, fila9 : bit_vector(0 to 7);

    signal filad_01, filad_23, filad_45, filad_67 : bit_vector(0 to 7);
    signal filad_0123, filad_4567, filad : bit_vector(0 to 7);

    signal filaV_01, filaV_23, filaV_45, filaV_67 : bit_vector(0 to 7);
    signal filaV_0123, filaV_4567, filaV : bit_vector(0 to 7);

    signal filae0_01, filae0_23, filae0_45, filae0_67 : bit_vector(0 to 7);
    signal filae0_0123, filae0_4567, filae0 : bit_vector(0 to 7);

    signal filae1_01, filae1_23, filae1_45, filae1_67 : bit_vector(0 to 7);
    signal filae1_0123, filae1_4567, filae1 : bit_vector(0 to 7);

    signal filae2_01, filae2_23, filae2_45, filae2_67 : bit_vector(0 to 7);
    signal filae2_0123, filae2_4567, filae2 : bit_vector(0 to 7);

    signal filae3_01, filae3_23, filae3_45, filae3_67 : bit_vector(0 to 7);
    signal filae3_0123, filae3_4567, filae3 : bit_vector(0 to 7);


    ----------------------------------------------------------------
    -- SELECCION DE CARACTER
    ----------------------------------------------------------------

    signal char_01, char_23, char_45, char_67 : bit_vector(0 to 7);
    signal char_89, char_dV : bit_vector(0 to 7);

    signal char_e0e1, char_e2e3 : bit_vector(0 to 7);

    signal char_0123, char_4567 : bit_vector(0 to 7);
    signal char_89dV, char_e : bit_vector(0 to 7);

    signal char_0_7, char_8_11 : bit_vector(0 to 7);
    signal char_12_15 : bit_vector(0 to 7);

    signal fila_final : bit_vector(0 to 7);


    ----------------------------------------------------------------
    -- SELECCION DE COLUMNA
    ----------------------------------------------------------------

    signal col01, col23, col45, col67 : bit_vector(0 to 0);
    signal col0123, col4567 : bit_vector(0 to 0);
    signal pixel : bit_vector(0 to 0);

begin

    ----------------------------------------------------------------
    -- CARACTER 0
    ----------------------------------------------------------------

    c0_f0 <= "00111100";
    c0_f1 <= "01000010";
    c0_f2 <= "01000010";
    c0_f3 <= "01000010";
    c0_f4 <= "01000010";
    c0_f5 <= "01000010";
    c0_f6 <= "01000010";
    c0_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 1
    ----------------------------------------------------------------

    c1_f0 <= "00001000";
    c1_f1 <= "00011000";
    c1_f2 <= "00111000";
    c1_f3 <= "01111000";
    c1_f4 <= "00011000";
    c1_f5 <= "00011000";
    c1_f6 <= "00011000";
    c1_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 2
    ----------------------------------------------------------------

    c2_f0 <= "00111100";
    c2_f1 <= "01000010";
    c2_f2 <= "00000010";
    c2_f3 <= "00000100";
    c2_f4 <= "00010000";
    c2_f5 <= "00100000";
    c2_f6 <= "01000000";
    c2_f7 <= "01111110";


    ----------------------------------------------------------------
    -- CARACTER 3
    ----------------------------------------------------------------

    c3_f0 <= "00111100";
    c3_f1 <= "01000010";
    c3_f2 <= "00000010";
    c3_f3 <= "00011100";
    c3_f4 <= "00000010";
    c3_f5 <= "00000010";
    c3_f6 <= "01000010";
    c3_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 4
    ----------------------------------------------------------------

    c4_f0 <= "00000100";
    c4_f1 <= "00001100";
    c4_f2 <= "00010100";
    c4_f3 <= "00100100";
    c4_f4 <= "01000100";
    c4_f5 <= "01111110";
    c4_f6 <= "00000100";
    c4_f7 <= "00000100";


    ----------------------------------------------------------------
    -- CARACTER 5
    ----------------------------------------------------------------

    c5_f0 <= "01111110";
    c5_f1 <= "01000000";
    c5_f2 <= "01000000";
    c5_f3 <= "01111100";
    c5_f4 <= "00000010";
    c5_f5 <= "00000010";
    c5_f6 <= "01000010";
    c5_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 6
    ----------------------------------------------------------------

    c6_f0 <= "00111100";
    c6_f1 <= "01000010";
    c6_f2 <= "01000000";
    c6_f3 <= "01111100";
    c6_f4 <= "01000010";
    c6_f5 <= "01000010";
    c6_f6 <= "01000010";
    c6_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 7
    ----------------------------------------------------------------

    c7_f0 <= "01111110";
    c7_f1 <= "00000010";
    c7_f2 <= "00000100";
    c7_f3 <= "00001000";
    c7_f4 <= "00010000";
    c7_f5 <= "00010000";
    c7_f6 <= "00010000";
    c7_f7 <= "00010000";


    ----------------------------------------------------------------
    -- CARACTER 8
    ----------------------------------------------------------------

    c8_f0 <= "00111100";
    c8_f1 <= "01000010";
    c8_f2 <= "01000010";
    c8_f3 <= "00111100";
    c8_f4 <= "01000010";
    c8_f5 <= "01000010";
    c8_f6 <= "01000010";
    c8_f7 <= "00111100";


    ----------------------------------------------------------------
    -- CARACTER 9
    ----------------------------------------------------------------

    c9_f0 <= "00111100";
    c9_f1 <= "01000010";
    c9_f2 <= "01000010";
    c9_f3 <= "00111110";
    c9_f4 <= "00000010";
    c9_f5 <= "00000010";
    c9_f6 <= "01000010";
    c9_f7 <= "00111100";


    ----------------------------------------------------------------
    -- PUNTO
    ----------------------------------------------------------------

    cd_f0 <= "00000000";
    cd_f1 <= "00000000";
    cd_f2 <= "00000000";
    cd_f3 <= "00000000";
    cd_f4 <= "00000000";
    cd_f5 <= "00000000";
    cd_f6 <= "00011000";
    cd_f7 <= "00011000";


    ----------------------------------------------------------------
    -- V
    ----------------------------------------------------------------

    cV_f0 <= "01000010";
    cV_f1 <= "01000010";
    cV_f2 <= "01000010";
    cV_f3 <= "01000010";
    cV_f4 <= "01000010";
    cV_f5 <= "00100100";
    cV_f6 <= "00100100";
    cV_f7 <= "00011000";


    ----------------------------------------------------------------
    -- ESPACIOS
    ----------------------------------------------------------------

    ce0_f0 <= "00000000";
    ce0_f1 <= "00000000";
    ce0_f2 <= "00000000";
    ce0_f3 <= "00000000";
    ce0_f4 <= "00000000";
    ce0_f5 <= "00000000";
    ce0_f6 <= "00000000";
    ce0_f7 <= "00000000";

    ce1_f0 <= "00000000";
    ce1_f1 <= "00000000";
    ce1_f2 <= "00000000";
    ce1_f3 <= "00000000";
    ce1_f4 <= "00000000";
    ce1_f5 <= "00000000";
    ce1_f6 <= "00000000";
    ce1_f7 <= "00000000";

    ce2_f0 <= "00000000";
    ce2_f1 <= "00000000";
    ce2_f2 <= "00000000";
    ce2_f3 <= "00000000";
    ce2_f4 <= "00000000";
    ce2_f5 <= "00000000";
    ce2_f6 <= "00000000";
    ce2_f7 <= "00000000";

    ce3_f0 <= "00000000";
    ce3_f1 <= "00000000";
    ce3_f2 <= "00000000";
    ce3_f3 <= "00000000";
    ce3_f4 <= "00000000";
    ce3_f5 <= "00000000";
    ce3_f6 <= "00000000";
    ce3_f7 <= "00000000";


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 0
    ----------------------------------------------------------------

    m0_01 : entity work.muxNbit generic map(N => 8)
        port map(c0_f0, c0_f1, row_addr(0), fila0_01);

    m0_23 : entity work.muxNbit generic map(N => 8)
        port map(c0_f2, c0_f3, row_addr(0), fila0_23);

    m0_45 : entity work.muxNbit generic map(N => 8)
        port map(c0_f4, c0_f5, row_addr(0), fila0_45);

    m0_67 : entity work.muxNbit generic map(N => 8)
        port map(c0_f6, c0_f7, row_addr(0), fila0_67);

    m0_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila0_01, fila0_23, row_addr(1), fila0_0123);

    m0_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila0_45, fila0_67, row_addr(1), fila0_4567);

    m0_final : entity work.muxNbit generic map(N => 8)
        port map(fila0_0123, fila0_4567, row_addr(2), fila0);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 1
    ----------------------------------------------------------------

    m1_01 : entity work.muxNbit generic map(N => 8)
        port map(c1_f0, c1_f1, row_addr(0), fila1_01);

    m1_23 : entity work.muxNbit generic map(N => 8)
        port map(c1_f2, c1_f3, row_addr(0), fila1_23);

    m1_45 : entity work.muxNbit generic map(N => 8)
        port map(c1_f4, c1_f5, row_addr(0), fila1_45);

    m1_67 : entity work.muxNbit generic map(N => 8)
        port map(c1_f6, c1_f7, row_addr(0), fila1_67);

    m1_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila1_01, fila1_23, row_addr(1), fila1_0123);

    m1_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila1_45, fila1_67, row_addr(1), fila1_4567);

    m1_final : entity work.muxNbit generic map(N => 8)
        port map(fila1_0123, fila1_4567, row_addr(2), fila1);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 2
    ----------------------------------------------------------------

    m2_01 : entity work.muxNbit generic map(N => 8)
        port map(c2_f0, c2_f1, row_addr(0), fila2_01);

    m2_23 : entity work.muxNbit generic map(N => 8)
        port map(c2_f2, c2_f3, row_addr(0), fila2_23);

    m2_45 : entity work.muxNbit generic map(N => 8)
        port map(c2_f4, c2_f5, row_addr(0), fila2_45);

    m2_67 : entity work.muxNbit generic map(N => 8)
        port map(c2_f6, c2_f7, row_addr(0), fila2_67);

    m2_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila2_01, fila2_23, row_addr(1), fila2_0123);

    m2_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila2_45, fila2_67, row_addr(1), fila2_4567);

    m2_final : entity work.muxNbit generic map(N => 8)
        port map(fila2_0123, fila2_4567, row_addr(2), fila2);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 3
    ----------------------------------------------------------------

    m3_01 : entity work.muxNbit generic map(N => 8)
        port map(c3_f0, c3_f1, row_addr(0), fila3_01);

    m3_23 : entity work.muxNbit generic map(N => 8)
        port map(c3_f2, c3_f3, row_addr(0), fila3_23);

    m3_45 : entity work.muxNbit generic map(N => 8)
        port map(c3_f4, c3_f5, row_addr(0), fila3_45);

    m3_67 : entity work.muxNbit generic map(N => 8)
        port map(c3_f6, c3_f7, row_addr(0), fila3_67);

    m3_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila3_01, fila3_23, row_addr(1), fila3_0123);

    m3_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila3_45, fila3_67, row_addr(1), fila3_4567);

    m3_final : entity work.muxNbit generic map(N => 8)
        port map(fila3_0123, fila3_4567, row_addr(2), fila3);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 4
    ----------------------------------------------------------------

    m4_01 : entity work.muxNbit generic map(N => 8)
        port map(c4_f0, c4_f1, row_addr(0), fila4_01);

    m4_23 : entity work.muxNbit generic map(N => 8)
        port map(c4_f2, c4_f3, row_addr(0), fila4_23);

    m4_45 : entity work.muxNbit generic map(N => 8)
        port map(c4_f4, c4_f5, row_addr(0), fila4_45);

    m4_67 : entity work.muxNbit generic map(N => 8)
        port map(c4_f6, c4_f7, row_addr(0), fila4_67);

    m4_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila4_01, fila4_23, row_addr(1), fila4_0123);

    m4_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila4_45, fila4_67, row_addr(1), fila4_4567);

    m4_final : entity work.muxNbit generic map(N => 8)
        port map(fila4_0123, fila4_4567, row_addr(2), fila4);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 5
    ----------------------------------------------------------------

    m5_01 : entity work.muxNbit generic map(N => 8)
        port map(c5_f0, c5_f1, row_addr(0), fila5_01);

    m5_23 : entity work.muxNbit generic map(N => 8)
        port map(c5_f2, c5_f3, row_addr(0), fila5_23);

    m5_45 : entity work.muxNbit generic map(N => 8)
        port map(c5_f4, c5_f5, row_addr(0), fila5_45);

    m5_67 : entity work.muxNbit generic map(N => 8)
        port map(c5_f6, c5_f7, row_addr(0), fila5_67);

    m5_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila5_01, fila5_23, row_addr(1), fila5_0123);

    m5_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila5_45, fila5_67, row_addr(1), fila5_4567);

    m5_final : entity work.muxNbit generic map(N => 8)
        port map(fila5_0123, fila5_4567, row_addr(2), fila5);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 6
    ----------------------------------------------------------------

    m6_01 : entity work.muxNbit generic map(N => 8)
        port map(c6_f0, c6_f1, row_addr(0), fila6_01);

    m6_23 : entity work.muxNbit generic map(N => 8)
        port map(c6_f2, c6_f3, row_addr(0), fila6_23);

    m6_45 : entity work.muxNbit generic map(N => 8)
        port map(c6_f4, c6_f5, row_addr(0), fila6_45);

    m6_67 : entity work.muxNbit generic map(N => 8)
        port map(c6_f6, c6_f7, row_addr(0), fila6_67);

    m6_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila6_01, fila6_23, row_addr(1), fila6_0123);

    m6_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila6_45, fila6_67, row_addr(1), fila6_4567);

    m6_final : entity work.muxNbit generic map(N => 8)
        port map(fila6_0123, fila6_4567, row_addr(2), fila6);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 7
    ----------------------------------------------------------------

    m7_01 : entity work.muxNbit generic map(N => 8)
        port map(c7_f0, c7_f1, row_addr(0), fila7_01);

    m7_23 : entity work.muxNbit generic map(N => 8)
        port map(c7_f2, c7_f3, row_addr(0), fila7_23);

    m7_45 : entity work.muxNbit generic map(N => 8)
        port map(c7_f4, c7_f5, row_addr(0), fila7_45);

    m7_67 : entity work.muxNbit generic map(N => 8)
        port map(c7_f6, c7_f7, row_addr(0), fila7_67);

    m7_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila7_01, fila7_23, row_addr(1), fila7_0123);

    m7_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila7_45, fila7_67, row_addr(1), fila7_4567);

    m7_final : entity work.muxNbit generic map(N => 8)
        port map(fila7_0123, fila7_4567, row_addr(2), fila7);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 8
    ----------------------------------------------------------------

    m8_01 : entity work.muxNbit generic map(N => 8)
        port map(c8_f0, c8_f1, row_addr(0), fila8_01);

    m8_23 : entity work.muxNbit generic map(N => 8)
        port map(c8_f2, c8_f3, row_addr(0), fila8_23);

    m8_45 : entity work.muxNbit generic map(N => 8)
        port map(c8_f4, c8_f5, row_addr(0), fila8_45);

    m8_67 : entity work.muxNbit generic map(N => 8)
        port map(c8_f6, c8_f7, row_addr(0), fila8_67);

    m8_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila8_01, fila8_23, row_addr(1), fila8_0123);

    m8_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila8_45, fila8_67, row_addr(1), fila8_4567);

    m8_final : entity work.muxNbit generic map(N => 8)
        port map(fila8_0123, fila8_4567, row_addr(2), fila8);


    ----------------------------------------------------------------
    -- MUX DE FILAS: CARACTER 9
    ----------------------------------------------------------------

    m9_01 : entity work.muxNbit generic map(N => 8)
        port map(c9_f0, c9_f1, row_addr(0), fila9_01);

    m9_23 : entity work.muxNbit generic map(N => 8)
        port map(c9_f2, c9_f3, row_addr(0), fila9_23);

    m9_45 : entity work.muxNbit generic map(N => 8)
        port map(c9_f4, c9_f5, row_addr(0), fila9_45);

    m9_67 : entity work.muxNbit generic map(N => 8)
        port map(c9_f6, c9_f7, row_addr(0), fila9_67);

    m9_0123 : entity work.muxNbit generic map(N => 8)
        port map(fila9_01, fila9_23, row_addr(1), fila9_0123);

    m9_4567 : entity work.muxNbit generic map(N => 8)
        port map(fila9_45, fila9_67, row_addr(1), fila9_4567);

    m9_final : entity work.muxNbit generic map(N => 8)
        port map(fila9_0123, fila9_4567, row_addr(2), fila9);


    ----------------------------------------------------------------
    -- MUX DE FILAS: PUNTO
    ----------------------------------------------------------------

    md_01 : entity work.muxNbit generic map(N => 8)
        port map(cd_f0, cd_f1, row_addr(0), filad_01);

    md_23 : entity work.muxNbit generic map(N => 8)
        port map(cd_f2, cd_f3, row_addr(0), filad_23);

    md_45 : entity work.muxNbit generic map(N => 8)
        port map(cd_f4, cd_f5, row_addr(0), filad_45);

    md_67 : entity work.muxNbit generic map(N => 8)
        port map(cd_f6, cd_f7, row_addr(0), filad_67);

    md_0123 : entity work.muxNbit generic map(N => 8)
        port map(filad_01, filad_23, row_addr(1), filad_0123);

    md_4567 : entity work.muxNbit generic map(N => 8)
        port map(filad_45, filad_67, row_addr(1), filad_4567);

    md_final : entity work.muxNbit generic map(N => 8)
        port map(filad_0123, filad_4567, row_addr(2), filad);


    ----------------------------------------------------------------
    -- MUX DE FILAS: V
    ----------------------------------------------------------------

    mV_01 : entity work.muxNbit generic map(N => 8)
        port map(cV_f0, cV_f1, row_addr(0), filaV_01);

    mV_23 : entity work.muxNbit generic map(N => 8)
        port map(cV_f2, cV_f3, row_addr(0), filaV_23);

    mV_45 : entity work.muxNbit generic map(N => 8)
        port map(cV_f4, cV_f5, row_addr(0), filaV_45);

    mV_67 : entity work.muxNbit generic map(N => 8)
        port map(cV_f6, cV_f7, row_addr(0), filaV_67);

    mV_0123 : entity work.muxNbit generic map(N => 8)
        port map(filaV_01, filaV_23, row_addr(1), filaV_0123);

    mV_4567 : entity work.muxNbit generic map(N => 8)
        port map(filaV_45, filaV_67, row_addr(1), filaV_4567);

    mV_final : entity work.muxNbit generic map(N => 8)
        port map(filaV_0123, filaV_4567, row_addr(2), filaV);


    ----------------------------------------------------------------
    -- MUX DE FILAS: ESPACIOS
    ----------------------------------------------------------------

    me0_01 : entity work.muxNbit generic map(N => 8)
        port map(ce0_f0, ce0_f1, row_addr(0), filae0_01);

    me0_23 : entity work.muxNbit generic map(N => 8)
        port map(ce0_f2, ce0_f3, row_addr(0), filae0_23);

    me0_45 : entity work.muxNbit generic map(N => 8)
        port map(ce0_f4, ce0_f5, row_addr(0), filae0_45);

    me0_67 : entity work.muxNbit generic map(N => 8)
        port map(ce0_f6, ce0_f7, row_addr(0), filae0_67);

    me0_0123 : entity work.muxNbit generic map(N => 8)
        port map(filae0_01, filae0_23, row_addr(1), filae0_0123);

    me0_4567 : entity work.muxNbit generic map(N => 8)
        port map(filae0_45, filae0_67, row_addr(1), filae0_4567);

    me0_final : entity work.muxNbit generic map(N => 8)
        port map(filae0_0123, filae0_4567, row_addr(2), filae0);


    me1_01 : entity work.muxNbit generic map(N => 8)
        port map(ce1_f0, ce1_f1, row_addr(0), filae1_01);

    me1_23 : entity work.muxNbit generic map(N => 8)
        port map(ce1_f2, ce1_f3, row_addr(0), filae1_23);

    me1_45 : entity work.muxNbit generic map(N => 8)
        port map(ce1_f4, ce1_f5, row_addr(0), filae1_45);

    me1_67 : entity work.muxNbit generic map(N => 8)
        port map(ce1_f6, ce1_f7, row_addr(0), filae1_67);

    me1_0123 : entity work.muxNbit generic map(N => 8)
        port map(filae1_01, filae1_23, row_addr(1), filae1_0123);

    me1_4567 : entity work.muxNbit generic map(N => 8)
        port map(filae1_45, filae1_67, row_addr(1), filae1_4567);

    me1_final : entity work.muxNbit generic map(N => 8)
        port map(filae1_0123, filae1_4567, row_addr(2), filae1);


    me2_01 : entity work.muxNbit generic map(N => 8)
        port map(ce2_f0, ce2_f1, row_addr(0), filae2_01);

    me2_23 : entity work.muxNbit generic map(N => 8)
        port map(ce2_f2, ce2_f3, row_addr(0), filae2_23);

    me2_45 : entity work.muxNbit generic map(N => 8)
        port map(ce2_f4, ce2_f5, row_addr(0), filae2_45);

    me2_67 : entity work.muxNbit generic map(N => 8)
        port map(ce2_f6, ce2_f7, row_addr(0), filae2_67);

    me2_0123 : entity work.muxNbit generic map(N => 8)
        port map(filae2_01, filae2_23, row_addr(1), filae2_0123);

    me2_4567 : entity work.muxNbit generic map(N => 8)
        port map(filae2_45, filae2_67, row_addr(1), filae2_4567);

    me2_final : entity work.muxNbit generic map(N => 8)
        port map(filae2_0123, filae2_4567, row_addr(2), filae2);


    me3_01 : entity work.muxNbit generic map(N => 8)
        port map(ce3_f0, ce3_f1, row_addr(0), filae3_01);

    me3_23 : entity work.muxNbit generic map(N => 8)
        port map(ce3_f2, ce3_f3, row_addr(0), filae3_23);

    me3_45 : entity work.muxNbit generic map(N => 8)
        port map(ce3_f4, ce3_f5, row_addr(0), filae3_45);

    me3_67 : entity work.muxNbit generic map(N => 8)
        port map(ce3_f6, ce3_f7, row_addr(0), filae3_67);

    me3_0123 : entity work.muxNbit generic map(N => 8)
        port map(filae3_01, filae3_23, row_addr(1), filae3_0123);

    me3_4567 : entity work.muxNbit generic map(N => 8)
        port map(filae3_45, filae3_67, row_addr(1), filae3_4567);

    me3_final : entity work.muxNbit generic map(N => 8)
        port map(filae3_0123, filae3_4567, row_addr(2), filae3);


    ----------------------------------------------------------------
    -- MUX DE CARACTER
    ----------------------------------------------------------------

    mc01 : entity work.muxNbit generic map(N => 8)
        port map(fila0, fila1, caracter_sel(0), char_01);

    mc23 : entity work.muxNbit generic map(N => 8)
        port map(fila2, fila3, caracter_sel(0), char_23);

    mc45 : entity work.muxNbit generic map(N => 8)
        port map(fila4, fila5, caracter_sel(0), char_45);

    mc67 : entity work.muxNbit generic map(N => 8)
        port map(fila6, fila7, caracter_sel(0), char_67);

    mc89 : entity work.muxNbit generic map(N => 8)
        port map(fila8, fila9, caracter_sel(0), char_89);

    mcdV : entity work.muxNbit generic map(N => 8)
        port map(filad, filaV, caracter_sel(0), char_dV);

    mce01 : entity work.muxNbit generic map(N => 8)
        port map(filae0, filae1, caracter_sel(0), char_e0e1);

    mce23 : entity work.muxNbit generic map(N => 8)
        port map(filae2, filae3, caracter_sel(0), char_e2e3);


    mc0123 : entity work.muxNbit generic map(N => 8)
        port map(char_01, char_23, caracter_sel(1), char_0123);

    mc4567 : entity work.muxNbit generic map(N => 8)
        port map(char_45, char_67, caracter_sel(1), char_4567);

    mc89dV : entity work.muxNbit generic map(N => 8)
        port map(char_89, char_dV, caracter_sel(1), char_89dV);

    mce : entity work.muxNbit generic map(N => 8)
        port map(char_e0e1, char_e2e3, caracter_sel(1), char_e);


    mc0_7 : entity work.muxNbit generic map(N => 8)
        port map(char_0123, char_4567, caracter_sel(2), char_0_7);

    mc8_11 : entity work.muxNbit generic map(N => 8)
        port map(char_89dV, char_e, caracter_sel(2), char_8_11);


    mc12_15 : entity work.muxNbit generic map(N => 8)
        port map(char_e, char_e, caracter_sel(2), char_12_15);


    mc_final : entity work.muxNbit generic map(N => 8)
        port map(char_0_7, char_8_11, caracter_sel(3), fila_final);


    ----------------------------------------------------------------
    -- MUX DE COLUMNAS
    ----------------------------------------------------------------

    mcol01 : entity work.muxNbit
        generic map(N => 1)
        port map(fila_final(0 to 0), fila_final(1 to 1),
                 col_addr(0), col01);

    mcol23 : entity work.muxNbit
        generic map(N => 1)
        port map(fila_final(2 to 2), fila_final(3 to 3),
                 col_addr(0), col23);

    mcol45 : entity work.muxNbit
        generic map(N => 1)
        port map(fila_final(4 to 4), fila_final(5 to 5),
                 col_addr(0), col45);

    mcol67 : entity work.muxNbit
        generic map(N => 1)
        port map(fila_final(6 to 6), fila_final(7 to 7),
                 col_addr(0), col67);

    mcol0123 : entity work.muxNbit
        generic map(N => 1)
        port map(col01, col23, col_addr(1), col0123);

    mcol4567 : entity work.muxNbit
        generic map(N => 1)
        port map(col45, col67, col_addr(1), col4567);

    mcol_final : entity work.muxNbit
        generic map(N => 1)
        port map(col0123, col4567, col_addr(2), pixel);


    pixel_on <= pixel(0);

end estructural;
