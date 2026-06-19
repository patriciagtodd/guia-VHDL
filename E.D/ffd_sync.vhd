entity ffd_sync is 
    port ( 
        ck   : in  bit; -- Reloj
        srst : in  bit; -- Synchronous Reset (Reset Sincrónico)
        d    : in  bit; -- Entrada de Dato
        q    : out bit  -- Salida
    );
end ffd_sync;

architecture beh of ffd_sync is 
begin
    -- LISTA DE SENSIBILIDAD: Solo el reloj
    process(ck)
    begin
        -- 1. Primero detectamos el flanco de subida
        if ck = '1' and ck'event then 
            -- 2. DENTRO del flanco, chequeamos el reset (Prioridad)
            if srst = '1' then
                q <= '0'; -- Solo cambia AQUÍ, sincronizado con el flanco
            else
                q <= d;   -- Si no hay reset, carga el dato
            end if;
        end if;
    end process;
end beh;