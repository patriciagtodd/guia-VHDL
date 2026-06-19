-- <=====================================================================>
-- <===== EJERCICIO 7: FLIP FLOP D CON RTS SINCRONICO Y ASINCRONICO =====>
-- <=====================================================================>

entity flip_flop_d is
    port (
        D_i    : in bit;     -- Entrada de datos
        clk    : in bit;     -- Señal de reloj
        arst_i : in bit;     -- Reset asincrónico (fuerza a 0 de inmediato)
        srst_i : in bit;     -- Reset sincrónico (fuerza a 0 en el flanco de reloj)
        Q_o    : out bit     -- Salida
    );
end flip_flop_d;

architecture flip_flop_d_arq of flip_flop_d is
begin
    -- => El PROCESS "escucha" los cambios en el reloj y en el reset ASINCRONICO
    process (clk, arst_i)    -- ¡Acá cambiamos arst por arst_i!
    begin
        -- Reset asincronico --> actua sin importar el reloj
        if arst_i = '1' then -- ¡Acá cambiamos arst por arst_i!
            Q_o <= '0';      -- ¡Acá cambiamos Q por Q_o!

        --Si el asincronico no esta apretado, esperamos al flanco de subida del reloj
        elsif clk'event and clk = '1' then

            -- Adentro del reloj --> evaluamos el reset SINCRONICO
            if srst_i = '1' then -- ¡Acá cambiamos srst por srst_i!
                Q_o <= '0';      -- ¡Acá cambiamos Q por Q_o!
            else
                Q_o <= D_i;      -- ¡Acá cambiamos Q por Q_o y D por D_i!
            end if;

        end if;
    end process;
end flip_flop_d_arq;