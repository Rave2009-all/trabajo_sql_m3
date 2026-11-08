CREATE DATABASE BibliotecaReservas2;
GO
 
USE BibliotecaReservas2;
GO
 
CREATE TABLE Usuarios (
    Usuario_ID INT NOT NULL,
    Nombre_Usuario VARCHAR(100) NOT NULL,
    Email_Usuario VARCHAR(100) NOT NULL,
    Tipo_Usuario VARCHAR(20) NOT NULL DEFAULT 'Estudiante'
);
GO
 
CREATE TABLE Editoriales (
    Editorial_ID INT NOT NULL,
    Nombre_Editorial VARCHAR(100) NOT NULL
);
GO
 
CREATE TABLE Categorias (
    Categoria_ID INT NOT NULL,
    Nombre_Categoria VARCHAR(50) NOT NULL
);
GO
 
CREATE TABLE Libros (
    Libro_ID INT NOT NULL,
    Titulo VARCHAR(150) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    Editorial_ID INT NOT NULL,
    Categoria_ID INT NOT NULL
);
GO
 
CREATE TABLE Reservas (
    Reserva_ID INT NOT NULL,
    Fecha_reserva DATE NOT NULL DEFAULT GETDATE(),
    Usuario_ID INT NOT NULL,
    Fecha_limite DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activa'
);
GO
 
CREATE TABLE Detalle_Reserva (
    Reserva_ID INT NOT NULL,
    Libro_ID INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    Notas VARCHAR(200)
);
GO
 
ALTER TABLE Usuarios
ADD CONSTRAINT PK_Usuarios PRIMARY KEY (Usuario_ID);
 
ALTER TABLE Usuarios
ADD CONSTRAINT UQ_Usuarios_Email UNIQUE (Email_Usuario);
 
ALTER TABLE Editoriales
ADD CONSTRAINT PK_Editoriales PRIMARY KEY (Editorial_ID);
 
ALTER TABLE Editoriales
ADD CONSTRAINT UQ_Editoriales_Nombre UNIQUE (Nombre_Editorial);
 
ALTER TABLE Categorias
ADD CONSTRAINT PK_Categorias PRIMARY KEY (Categoria_ID);
 
ALTER TABLE Categorias
ADD CONSTRAINT UQ_Categorias_Nombre UNIQUE (Nombre_Categoria);
 
ALTER TABLE Libros
ADD CONSTRAINT PK_Libros PRIMARY KEY (Libro_ID);
 
ALTER TABLE Reservas
ADD CONSTRAINT PK_Reservas PRIMARY KEY (Reserva_ID);
 
ALTER TABLE Detalle_Reserva
ADD CONSTRAINT PK_Detalle_Reserva PRIMARY KEY (Reserva_ID, Libro_ID);
 
ALTER TABLE Libros
ADD CONSTRAINT FK_Libros_Editoriales
FOREIGN KEY (Editorial_ID) REFERENCES Editoriales(Editorial_ID);
 
ALTER TABLE Libros
ADD CONSTRAINT FK_Libros_Categorias
FOREIGN KEY (Categoria_ID) REFERENCES Categorias(Categoria_ID);
 
ALTER TABLE Reservas
ADD CONSTRAINT FK_Reservas_Usuarios
FOREIGN KEY (Usuario_ID) REFERENCES Usuarios(Usuario_ID);
 
ALTER TABLE Detalle_Reserva
ADD CONSTRAINT FK_Detalle_Reservas
FOREIGN KEY (Reserva_ID) REFERENCES Reservas(Reserva_ID);
 
ALTER TABLE Detalle_Reserva
ADD CONSTRAINT FK_Detalle_Libros
FOREIGN KEY (Libro_ID) REFERENCES Libros(Libro_ID);
 
ALTER TABLE Detalle_Reserva
ADD CONSTRAINT CK_Detalle_Cantidad CHECK (Cantidad > 0);
 
ALTER TABLE Reservas
ADD CONSTRAINT CK_Reservas_Fechas CHECK (Fecha_limite >= Fecha_reserva);
GO
 
INSERT INTO Usuarios (Usuario_ID, Nombre_Usuario, Email_Usuario, Tipo_Usuario) VALUES
(1, 'Juan Perez', 'juan@gmail.com', 'Estudiante'),
(2, 'Maria Gomez', 'maria@gmail.com', 'Estudiante'),
(3, 'Carlos Lopez', 'carlos@gmail.com', 'Docente'),
(4, 'Ana Rodriguez', 'ana@gmail.com', 'Estudiante'),
(5, 'Luis Martinez', 'luis@gmail.com', 'Externo'),
(6, 'Laura Sanchez', 'laura@gmail.com', 'Estudiante'),
(7, 'Pedro Ramirez', 'pedro@gmail.com', 'Docente'),
(8, 'Sofia Torres', 'sofia@gmail.com', 'Estudiante'),
(9, 'Andres Garcia', 'andres@gmail.com', 'Externo'),
(10, 'Valentina Diaz', 'valentina@gmail.com', 'Estudiante'),
(11, 'David Hernandez', 'david@gmail.com', 'Estudiante'),
(12, 'Camila Castro', 'camila@gmail.com', 'Docente'),
(13, 'Jorge Morales', 'jorge@gmail.com', 'Estudiante'),
(14, 'Isabella Ruiz', 'isabella@gmail.com', 'Externo'),
(15, 'Daniel Vargas', 'daniel@gmail.com', 'Estudiante'),
(16, 'Paula Jimenez', 'paula@gmail.com', 'Estudiante'),
(17, 'Miguel Alvarez', 'miguel@gmail.com', 'Docente'),
(18, 'Sara Rojas', 'sara@gmail.com', 'Estudiante'),
(19, 'Felipe Ortiz', 'felipe@gmail.com', 'Externo'),
(20, 'Natalia Marin', 'natalia@gmail.com', 'Estudiante');
GO
 
INSERT INTO Editoriales (Editorial_ID, Nombre_Editorial) VALUES
(1, 'Planeta'),
(2, 'Penguin Random House'),
(3, 'Alfaguara'),
(4, 'Salamandra'),
(5, 'Anagrama'),
(6, 'Tusquets'),
(7, 'Debolsillo'),
(8, 'Alianza Editorial'),
(9, 'Catedra'),
(10, 'Siruela'),
(11, 'Norma'),
(12, 'Oceano'),
(13, 'Espasa'),
(14, 'Booket'),
(15, 'Minotauro'),
(16, 'Edhasa'),
(17, 'Acantilado'),
(18, 'Seix Barral'),
(19, 'Santillana'),
(20, 'Nordica');
GO
 
INSERT INTO Categorias (Categoria_ID, Nombre_Categoria) VALUES
(1, 'Novela'),
(2, 'Infantil'),
(3, 'Clasico'),
(4, 'Fantasia'),
(5, 'Suspenso'),
(6, 'Romance'),
(7, 'Drama'),
(8, 'Terror'),
(9, 'Ficcion'),
(10, 'Historia'),
(11, 'Ciencia'),
(12, 'Poesia'),
(13, 'Biografia'),
(14, 'Aventura'),
(15, 'Misterio'),
(16, 'Filosofia'),
(17, 'Tecnologia'),
(18, 'Humor'),
(19, 'Ensayo'),
(20, 'Cuento');
GO
 
INSERT INTO Libros (Libro_ID, Titulo, Autor, Editorial_ID, Categoria_ID) VALUES
(1, 'Cien anos de soledad', 'Gabriel Garcia Marquez', 3, 1),
(2, 'El principito', 'Antoine de Saint-Exupery', 4, 2),
(3, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 9, 3),
(4, 'La odisea', 'Homero', 8, 3),
(5, 'Harry Potter', 'J. K. Rowling', 4, 4),
(6, 'El codigo Da Vinci', 'Dan Brown', 1, 5),
(7, 'Orgullo y prejuicio', 'Jane Austen', 8, 6),
(8, 'La iliada', 'Homero', 8, 3),
(9, 'Crimen y castigo', 'Fiodor Dostoievski', 7, 7),
(10, 'It', 'Stephen King', 2, 8),
(11, 'El alquimista', 'Paulo Coelho', 1, 9),
(12, 'Rayuela', 'Julio Cortazar', 3, 1),
(13, 'Dracula', 'Bram Stoker', 7, 8),
(14, 'Frankenstein', 'Mary Shelley', 7, 8),
(15, 'Los juegos del hambre', 'Suzanne Collins', 11, 4),
(16, 'El hobbit', 'J. R. R. Tolkien', 15, 4),
(17, 'Rebelion en la granja', 'George Orwell', 2, 9),
(18, '1984', 'George Orwell', 2, 9),
(19, 'La metamorfosis', 'Franz Kafka', 8, 3),
(20, 'El diario de Ana Frank', 'Ana Frank', 19, 10);
GO
 
INSERT INTO Reservas (Reserva_ID, Fecha_reserva, Usuario_ID, Fecha_limite, Estado) VALUES
(1, '2026-02-01', 1, '2026-02-15', 'Finalizada'),
(2, '2026-02-05', 2, '2026-02-19', 'Finalizada'),
(3, '2026-02-10', 3, '2026-02-24', 'Finalizada'),
(4, '2026-02-15', 4, '2026-03-01', 'Finalizada'),
(5, '2026-02-20', 5, '2026-03-06', 'Finalizada'),
(6, '2026-03-01', 6, '2026-03-15', 'Finalizada'),
(7, '2026-03-05', 7, '2026-03-19', 'Finalizada'),
(8, '2026-03-10', 8, '2026-03-24', 'Vencida'),
(9, '2026-03-15', 9, '2026-03-29', 'Finalizada'),
(10, '2026-03-20', 10, '2026-04-03', 'Vencida'),
(11, '2026-04-01', 11, '2026-04-15', 'Finalizada'),
(12, '2026-04-05', 12, '2026-04-19', 'Vencida'),
(13, '2026-04-10', 13, '2026-04-24', 'Activa'),
(14, '2026-04-15', 14, '2026-04-29', 'Activa'),
(15, '2026-04-20', 15, '2026-05-04', 'Activa'),
(16, '2026-05-02', 16, '2026-05-16', 'Activa'),
(17, '2026-05-06', 17, '2026-05-20', 'Activa'),
(18, '2026-05-10', 18, '2026-05-24', 'Activa'),
(19, '2026-05-15', 19, '2026-05-29', 'Activa'),
(20, '2026-05-20', 20, '2026-06-03', 'Activa');
GO
 
INSERT INTO Detalle_Reserva (Reserva_ID, Libro_ID, Cantidad, Notas) VALUES
(1, 1, 1, 'Sin novedad'),
(1, 5, 1, NULL),
(2, 2, 1, NULL),
(3, 3, 1, 'Edicion de bolsillo'),
(3, 10, 1, 'Segundo libro de la reserva'),
(4, 4, 1, NULL),
(5, 5, 2, 'Para clase de lectura'),
(6, 6, 1, NULL),
(6, 12, 1, NULL),
(7, 7, 1, 'Sin novedad'),
(8, 8, 1, 'Entrega tardia'),
(9, 9, 1, NULL),
(10, 10, 1, 'Entrega tardia'),
(11, 11, 1, NULL),
(12, 12, 1, 'Entrega tardia'),
(13, 13, 1, NULL),
(13, 1, 1, NULL),
(14, 14, 1, 'Libro en buen estado'),
(15, 15, 2, NULL),
(16, 16, 1, 'Sin novedad'),
(17, 17, 1, NULL),
(18, 18, 1, 'Reserva prioritaria'),
(19, 19, 1, NULL),
(20, 20, 1, 'Sin novedad');
GO
 
UPDATE Usuarios
SET Tipo_Usuario = 'Docente'
WHERE Usuario_ID = 4;
GO
 
UPDATE Detalle_Reserva
SET Notas = 'Libro revisado al devolver'
WHERE Reserva_ID = 1 AND Libro_ID = 1;
GO
 
SELECT * 
FROM Usuarios;
 
SELECT * 
FROM Editoriales;
 
SELECT * 
FROM Categorias;
 
SELECT * 
FROM Libros;
 
SELECT * 
FROM Reservas;
 
SELECT * 
FROM Detalle_Reserva;
 
-- Consulta 1: ¿Cuantos libros hay por categoria, mostrando solo las categorias con mas de un libro?
SELECT C.Nombre_Categoria, COUNT(*) AS CantidadLibros
FROM Libros L
INNER JOIN Categorias C ON L.Categoria_ID = C.Categoria_ID
GROUP BY C.Nombre_Categoria
HAVING COUNT(*) > 1;
 
-- Consulta 2: ¿Que usuario hizo cada reserva y que libros incluye?
SELECT U.Nombre_Usuario, R.Reserva_ID, L.Titulo, D.Cantidad, R.Estado
FROM Reservas R
INNER JOIN Usuarios U ON R.Usuario_ID = U.Usuario_ID
INNER JOIN Detalle_Reserva D ON R.Reserva_ID = D.Reserva_ID
INNER JOIN Libros L ON D.Libro_ID = L.Libro_ID;
 
-- Consulta 3: ¿Cuantos libros tiene cada editorial, incluyendo las editoriales sin libros?
SELECT E.Nombre_Editorial, COUNT(L.Libro_ID) AS CantidadLibros
FROM Editoriales E
LEFT JOIN Libros L ON E.Editorial_ID = L.Editorial_ID
GROUP BY E.Nombre_Editorial;
 
-- Consulta 4: ¿Cuantas reservas se hicieron en cada mes de 2026, mostrando solo los meses con mas de 3 reservas?
SELECT MONTH(Fecha_reserva) AS Mes, COUNT(*) AS TotalReservas
FROM Reservas
WHERE YEAR(Fecha_reserva) = 2026
GROUP BY MONTH(Fecha_reserva)
HAVING COUNT(*) > 3;
 
-- Consulta 5: ¿Cuantos dias han pasado desde la fecha limite de las reservas activas?
SELECT U.Nombre_Usuario, R.Reserva_ID, R.Fecha_limite, DATEDIFF(DAY, R.Fecha_limite, GETDATE()) AS DiasDesdeLimite
FROM Reservas R
INNER JOIN Usuarios U ON R.Usuario_ID = U.Usuario_ID
WHERE R.Estado = 'Activa';
 
-- Consulta 6: ¿Cuantas unidades en total han reservado los usuarios de cada tipo, mostrando solo los tipos con mas de 3 unidades?
SELECT U.Tipo_Usuario, SUM(D.Cantidad) AS TotalUnidades
FROM Usuarios U
INNER JOIN Reservas R ON U.Usuario_ID = R.Usuario_ID
INNER JOIN Detalle_Reserva D ON R.Reserva_ID = D.Reserva_ID
GROUP BY U.Tipo_Usuario
HAVING SUM(D.Cantidad) > 3;
 
-- Consulta 7: ¿Cuantas veces ha sido reservado cada libro, ordenado de mayor a menor?
SELECT L.Titulo, COUNT(D.Reserva_ID) AS VecesReservado
FROM Libros L
LEFT JOIN Detalle_Reserva D ON L.Libro_ID = D.Libro_ID
GROUP BY L.Titulo
ORDER BY VecesReservado DESC;
GO

CREATE PROCEDURE BuscarReservasPorUsuario
    @Usuario_ID INT,
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        U.Nombre_Usuario,
        R.Reserva_ID,
        R.Fecha_reserva,
        R.Fecha_limite,
        L.Titulo,
        D.Cantidad,
        R.Estado
    FROM Reservas R
    INNER JOIN Usuarios U
        ON R.Usuario_ID = U.Usuario_ID
    INNER JOIN Detalle_Reserva D
        ON R.Reserva_ID = D.Reserva_ID
    INNER JOIN Libros L
        ON D.Libro_ID = L.Libro_ID
    WHERE R.Usuario_ID = @Usuario_ID
    AND R.Fecha_reserva BETWEEN @FechaInicio AND @FechaFin;
END;
GO

CREATE PROCEDURE RegistrarReservaCompleta
    @Reserva_ID INT,
    @Usuario_ID INT,
    @Libro_ID INT,
    @Cantidad INT,
    @Fecha_limite DATE,
    @Notas VARCHAR(200)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Reservas
        (Reserva_ID, Usuario_ID, Fecha_limite, Estado)
        VALUES
        (@Reserva_ID, @Usuario_ID, @Fecha_limite, 'Activa');

        INSERT INTO Detalle_Reserva
        (Reserva_ID, Libro_ID, Cantidad, Notas)
        VALUES
        (@Reserva_ID, @Libro_ID, @Cantidad, @Notas);

        COMMIT TRANSACTION;

        PRINT 'Reserva registrada correctamente';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'Error al registrar la reserva';
        THROW;
    END CATCH
END;
GO

CREATE PROCEDURE CambiarEstadoReserva
    @Reserva_ID INT,
    @NuevoEstado VARCHAR(20)
AS
BEGIN
    UPDATE Reservas
    SET Estado = @NuevoEstado
    WHERE Reserva_ID = @Reserva_ID;

    IF @@ROWCOUNT > 0
        PRINT 'Estado actualizado correctamente';
    ELSE
        PRINT 'No se encontro la reserva';
END;
GO

CREATE PROCEDURE ReporteLibrosReservados
AS
BEGIN
    SELECT
        L.Libro_ID,
        L.Titulo,
        L.Autor,
        COUNT(D.Reserva_ID) AS VecesReservado,
        SUM(D.Cantidad) AS TotalUnidades
    FROM Libros L
    INNER JOIN Detalle_Reserva D
        ON L.Libro_ID = D.Libro_ID
    GROUP BY
        L.Libro_ID,
        L.Titulo,
        L.Autor
    ORDER BY VecesReservado DESC;
END;
GO
