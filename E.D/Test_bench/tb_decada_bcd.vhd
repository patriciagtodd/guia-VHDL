entity tb_decada_bcd is
end tb_decada_bcd;

architecture sim of tb_decada_bcd is

    signal clk       : bit := '0';
    signal rst       : bit := '1';
    signal habilita  : bit := '0';
    signal q         : bit_vector(3 downto 0);
    signal carry_out : bit;

begin

    DUT : entity work.decada_bcd
        port map (
            clk       => clk,
            rst       => rst,
            habilita  => habilita,
            q         => q,
            carry_out => carry_out
        );

    -- Reloj de simulacion: periodo 20 ns (la frecuencia real no importa aca,
    -- lo que importa es la cuenta de flancos)
    clk <= not clk after 10 ns;

    process
    begin
        -- Reset inicial
        rst      <= '1';
        habilita <= '0';
        wait for 25 ns;
        rst <= '0';

        --------------------------------------------------------------
        -- FASE 1: habilita siempre en '1' -> cuenta en cada flanco.
        -- Deberiamos ver 0,1,2,...,9,0,1 y un pulso de carry_out
        -- justo en el flanco donde q pasa de 9 a 0.
        --------------------------------------------------------------
        habilita <= '1';
        wait for 12 * 20 ns;  -- 12 flancos de subida

        --------------------------------------------------------------
        -- FASE 2: reset y luego habilita en '1' solo cada 2 flancos
        -- (simula un bitstream con densidad de unos del 50%, como
        -- si el sigma-delta estuviera viendo ~5.00V). El contador
        -- deberia avanzar 1 digito cada 2 flancos de reloj.
        --------------------------------------------------------------
        rst      <= '1';
        habilita <= '0';
        wait for 20 ns;
        rst <= '0';

        for i in 0 to 19 loop
            wait until clk'event and clk = '1';
            wait for 5 ns;  -- nos corremos del flanco para evitar carreras
            if (i mod 2) = 0 then
                habilita <= '1';
            else
                habilita <= '0';
            end if;
            wait for 5 ns;  -- volvemos a estar listos antes del proximo flanco
        end loop;

        habilita <= '0';
        wait;

    end process;

end sim;