
import psycopg2
import pytest
from decimal import Decimal

def test_new_sql_functions():
    conn = None
    try:
        conn = psycopg2.connect(
            dbname='test_db',
            user='postgres',
            password='postgres',
            host='localhost',
            port='5432'
        )
        cur = conn.cursor()

        cur.execute("SELECT precio_final(100, 25);")
        precio_resultado = cur.fetchone()[0]
        assert precio_resultado == Decimal('75.0')
        
        cur.execute("SELECT correo_valido('test@example.com');")
        assert cur.fetchone()[0] is True
        
        cur.execute("SELECT correo_valido('test.example.com');")
        assert cur.fetchone()[0] is False

        cur.execute("SELECT dia_semana('2025-11-09'::DATE);")
        nombre_dia = cur.fetchone()[0].strip()
        assert nombre_dia == 'SUNDAY'

        cur.execute("SELECT * FROM bajo_stock(40);")
        resultados_stock = cur.fetchall()
        
        assert len(resultados_stock) == 4
        
        nombres_productos = [row[1] for row in resultados_stock]
        
        nombres_esperados = ['Silla', 'Mouse', 'Laptop', 'Cafetera']
        assert nombres_productos == nombres_esperados
        
        cur.execute("SELECT contar_empleados(1);")
        assert cur.fetchone()[0] == 2
        
        cur.execute("SELECT contar_empleados(2);")
        assert cur.fetchone()[0] == 3

        cur.execute("SELECT contar_empleados(3);")
        assert cur.fetchone()[0] == 0

    finally:
        if conn:
            conn.rollback() 
            cur.close()
            conn.close()
          
