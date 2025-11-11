
CREATE TABLE productos (
  Id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  precio NUMERIC NOT NULL,
  stock INT NOT NULL DEFAULT 0
);

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    id_departamento INT, 
    FOREIGN KEY(id_departamento) REFERENCES departamentos(id)
);
