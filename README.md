# BibliotecaReservas - Base de datos

Base de datos del sistema de reservas de libros de una biblioteca.

## 1. Descripcion tecnica

- **Motor:** Microsoft SQL Server (SQL Server Management Studio)
- **Nombre de la base de datos:** BibliotecaReservas
- **Cantidad de tablas:** 6 (Usuarios, Editoriales, Categorias, Libros, Reservas, Detalle_Reserva)
- **Procedimientos almacenados:** 4
- **Script:** `BibliotecaReservas.sql` (DDL, DML, consultas y procedimientos)

### Como ejecutarlo

1. Abrir `BibliotecaReservas.sql` en SQL Server Management Studio.
2. Presionar F5 para ejecutar todo el script.
3. Verificar los procedimientos con `SELECT name FROM sys.procedures;`

### Procedimientos almacenados

| Procedimiento | Descripcion |
|---|---|
| BuscarReservasPorUsuario | Recibe un ID de usuario y un rango de fechas, y devuelve sus reservas con los libros reservados. |
| RegistrarReservaCompleta | Inserta una reserva y su detalle dentro de una transaccion. Si algo falla, deshace todo. |
| CambiarEstadoReserva | Actualiza el estado de una reserva a partir de su ID. |
| ReporteLibrosReservados | Muestra cuantas veces se reservo cada libro y el total de unidades. |

## 2. Diccionario de datos

### Usuarios

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Usuario_ID | INT | PK | Identificador del usuario |
| Nombre_Usuario | VARCHAR(100) | | Nombre completo |
| Email_Usuario | VARCHAR(100) | UNIQUE | Correo electronico |
| Tipo_Usuario | VARCHAR(20) | | Estudiante, Docente o Externo (por defecto Estudiante) |

### Editoriales

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Editorial_ID | INT | PK | Identificador de la editorial |
| Nombre_Editorial | VARCHAR(100) | UNIQUE | Nombre de la editorial |

### Categorias

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Categoria_ID | INT | PK | Identificador de la categoria |
| Nombre_Categoria | VARCHAR(50) | UNIQUE | Nombre de la categoria |

### Libros

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Libro_ID | INT | PK | Identificador del libro |
| Titulo | VARCHAR(150) | | Titulo del libro |
| Autor | VARCHAR(100) | | Autor del libro |
| Editorial_ID | INT | FK -> Editoriales | Editorial del libro |
| Categoria_ID | INT | FK -> Categorias | Categoria del libro |

### Reservas

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Reserva_ID | INT | PK | Identificador de la reserva |
| Fecha_reserva | DATE | | Fecha en que se hizo la reserva (por defecto la fecha actual) |
| Usuario_ID | INT | FK -> Usuarios | Usuario que reserva |
| Fecha_limite | DATE | | Fecha limite de devolucion (debe ser mayor o igual a Fecha_reserva) |
| Estado | VARCHAR(20) | | Activa, Finalizada o Vencida (por defecto Activa) |

### Detalle_Reserva

| Columna | Tipo | Llave | Descripcion |
|---|---|---|---|
| Reserva_ID | INT | PK, FK -> Reservas | Reserva a la que pertenece |
| Libro_ID | INT | PK, FK -> Libros | Libro reservado |
| Cantidad | INT | | Unidades reservadas (debe ser mayor a 0, por defecto 1) |
| Notas | VARCHAR(200) | | Observaciones opcionales |

### Relaciones

- Un usuario puede tener muchas reservas (Usuarios 1:N Reservas).
- Una reserva puede incluir muchos libros y un libro puede estar en muchas reservas (Reservas N:M Libros, resuelta con Detalle_Reserva).
- Una editorial y una categoria pueden tener muchos libros (Editoriales 1:N Libros, Categorias 1:N Libros).

## 3. Explicacion de relacion con los otros submodulos

### Submodulos del proyecto

El proyecto integrador esta formado por tres submodulos:

- **Base de datos (este submodulo):** disena y documenta la base de datos BibliotecaReservas en SQL Server, con su script, sus procedimientos almacenados y este README.
- **Programacion de Aplicaciones Móviles I:** programacion orientada a objetos con Java. Aqui estan las clases del sistema (logica del backend).
- **Programacion para la Web 1:** JavaScript para aplicaciones web y manejo del DOM. Aqui estan las vistas del front.

Los tres submodulos pertenecen al mismo sistema de reservas de libros y trabajan sobre el mismo modelo de datos, pero en este nivel estan relacionados conceptualmente y no conectados tecnicamente.

### Relacion entre las clases y las tablas

Cada clase del proyecto Java corresponde a una tabla del diagrama MER:

| Clase | Tabla |
|---|---|
| Usuario | Usuarios |
| Editorial | Editoriales |
| Categoria | Categorias |
| Libro | Libros |
| Reserva | Reservas |
| Detalle de reserva | Detalle_Reserva |

Los atributos de cada clase coinciden con las columnas de su tabla, y las relaciones entre clases (un usuario tiene reservas, una reserva tiene detalles, un detalle apunta a un libro, un libro tiene editorial y categoria) son las mismas llaves foraneas del script SQL.

La clase `Libro` incluye ademas un atributo `portada` (URL de la imagen) que se usa para mostrar la portada en el catalogo. Este atributo es de presentacion y no forma parte del script de SQL Server.

### Conexion tecnica entre el proyecto y la base de datos

El proyecto no esta conectado a SQL Server. La aplicacion Java usa una base de datos en Neon (PostgreSQL) con la misma estructura de tablas y relaciones definida en este script. SQL Server se uso para disenar y probar el modelo, las consultas y los procedimientos almacenados; Neon es la base que usa la aplicacion en funcionamiento. Como ambas comparten estructura, el diseno de este submodulo es el que respalda la logica del proyecto.

### Relacion entre las vistas del front y la logica implementada

Las vistas del front son **Inicio**, **Catalogo** y **Mis Reservas**:

- **Inicio:** presenta el sistema y da acceso a las demas vistas.
- **Catalogo:** muestra los libros con su titulo, autor y portada. Corresponde a la informacion de la tabla Libros (con su editorial y categoria) y es la base para crear una reserva, como lo hace el procedimiento `RegistrarReservaCompleta`.
- **Mis Reservas:** muestra las reservas de un usuario con sus libros, fechas y estado. Es la misma logica de `BuscarReservasPorUsuario`, y el cambio de estado de una reserva equivale a `CambiarEstadoReserva`.

De esta forma las vistas sirven para la logica implementada: cada pantalla presenta datos que provienen de las tablas del modelo y de las operaciones que representan los procedimientos almacenados.
