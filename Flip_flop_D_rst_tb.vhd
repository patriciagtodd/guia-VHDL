-- ========================================================
-- BANCO DE PRUEBAS PARA FLIP-FLOP D CON RESETS (EJ 7)
-- ========================================================

entity testbench_ej7 is
end testbench_ej7;

architecture simulacion of testbench_ej7 is

    -- 1. Zócalo de tu componente
    component flip_flop_d
        port (
            D_i    : in bit;
            clk    : in bit;
            arst_i : in bit;
            srst_i : in bit;
            Q_o    : out bit
        );
    end component;

    -- 2. Señales internas
    -- ¡OJO!: Le damos un valor inicial al reloj ('0') para que pueda empezar a oscilar
    signal tst_clk  : bit := '0';
    signal tst_D    : bit := '0';
    signal tst_arst : bit := '0';
    signal tst_srst : bit := '0';
    signal tst_Q    : bit;

begin
    -- 3. Instanciamos el flip-flop
    prueba_ffd: flip_flop_d
        port map (
            D_i    => tst_D,
            clk    => tst_clk,
            arst_i => tst_arst,
            srst_i => tst_srst,
            Q_o    => tst_Q
        );

    -- 4. Generador de RELOJ
    -- Esta instrucción hace que el reloj cambie de estado cada 10 ns (Período total = 20 ns)
    tst_clk <= not tst_clk after 10 ns;

    -- 5. Estímulos
    -- RESET ASINCRÓNICO: Lo apretamos al inicio y luego a los 125 ns (justo en el medio de un ciclo)
    tst_arst <= '1',
                '0' after 15 ns,
                '1' after 125 ns,
                '0' after 145 ns;

    -- RESET SINCRÓNICO: Lo apretamos a los 65 ns
    tst_srst <= '0',
                '1' after 65 ns,
                '0' after 95 ns;

    -- DATO D: Lo subimos a '1' a los 25 ns y lo dejamos ahí fijo para que intente guardarlo
    tst_D    <= '0',
                '1' after 25 ns; 

end simulacion;