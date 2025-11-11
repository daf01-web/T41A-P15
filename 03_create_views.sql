
--Crea una función que calcule el descuento aplicado al producto.
CREATE OR REPLACE FUNCTION precio_final(
    precio_original NUMERIC, 
    porcentaje_descuento NUMERIC
)
RETURNS NUMERIC AS $$
BEGIN
    RETURN precio_original * (1.0 - (porcentaje_descuento / 100.0));
END;
$$ LANGUAGE plpgsql;

SELECT precio_final(100, 25);




--Crea una función que valida si el correo electrónico contiene '@'.
CREATE OR REPLACE FUNCTION correo_valido(p_correo TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (p_correo LIKE '%@%');
END;
$$ LANGUAGE plpgsql;

SELECT correo_valido('uncorreo@gmail.com');




--Crea una función que devuelva los productos con stock menor a un valor dado.
CREATE OR REPLACE FUNCTION bajo_stock(
    p_cantidad_minima INT
)
RETURNS TABLE (
    id INT,
    nombre TEXT,
    precio NUMERIC,
    stock INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            p.id,
            p.nombre,
            p.precio,
            p.stock
        FROM
            productos AS p
        WHERE
            p.stock < p_cantidad_minima
        ORDER BY
            p.stock; 
END;
$$;

SELECT * FROM bajo_stock(40);



--Crea una función que recibe una fecha y devuelve el día de la semana.
CREATE OR REPLACE FUNCTION dia_semana(p_fecha DATE)
RETURNS TEXT AS $$
BEGIN
    RETURN TO_CHAR(p_fecha, 'TMDAY');
END;
$$ LANGUAGE plpgsql;

SELECT
    CURRENT_DATE AS fecha,
    dia_semana(CURRENT_DATE) AS dia;



--Crea una función que cuenta cuántos empleados hay en un departamento.
CREATE OR REPLACE FUNCTION contar_empleados(id_depto INT)
RETURNS INT AS $$
DECLARE
    conteo INT;
BEGIN
   SELECT COUNT(*) 
   INTO conteo
   FROM empleados
   WHERE id_departamento = id_depto; 
   
   RETURN conteo;
END;
$$ LANGUAGE plpgsql;

SELECT contar_empleados(2);
