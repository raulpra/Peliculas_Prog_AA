CREATE DATABASE IF NOT EXISTS cineapp;
GRANT ALL PRIVILEGES ON cineapp.* TO user;
USE cineapp;

CREATE TABLE generos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        descripcion VARCHAR(255),
        ejemplos TEXT,
        fecha_agregado DATE,
        activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE,
        edad INT,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        role VARCHAR(100) NOT NULL,
        activo BOOLEAN DEFAULT TRUE,
        valoracion DECIMAL(3,1)
);

CREATE TABLE peliculas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        titulo VARCHAR(200),
        director VARCHAR(200),
        sinopsis TEXT,
        fecha_estreno DATE,
        imagen VARCHAR(255),
        puntuacion DECIMAL(3,1),
        disponible BOOLEAN DEFAULT TRUE,
        id_genero INT,
        foreign KEY (id_genero) REFERENCES generos(id) ON DELETE CASCADE
);

CREATE TABLE favoritos (
        id_usuario INT,
        id_pelicula INT,
        fecha_agregado DATE,
        PRIMARY KEY (id_usuario, id_pelicula),
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
        FOREIGN KEY (id_pelicula) REFERENCES peliculas(id) ON DELETE CASCADE
);


INSERT INTO generos (nombre, descripcion, ejemplos, fecha_agregado, activo) VALUES
        ('Acción', 'Películas con escenas intensas y ritmo rápido', 'Rápidos y Furiosos, John Wick', '2024-01-10',TRUE),
        ('Comedia', 'Películas que buscan hacer reír al público', 'Scary Movie, Superbad', '2024-01-11',TRUE),
        ('Drama', 'Historias profundas y emocionales', 'El Padrino, Forrest Gump', '2024-01-12',TRUE),
        ('Ciencia Ficción', 'Películas con tecnología avanzada o mundos imaginarios', 'Interestelar, Blade Runner', '2024-01-13',TRUE),
        ('Terror', 'Películas de miedo o suspenso extremo', 'El Conjuro, It', '2024-01-14',TRUE),
        ('Romance', 'Películas centradas en el amor', 'Titanic, The Notebook', '2024-01-15', TRUE),
        ('Animación', 'Películas creadas por animación digital o tradicional', 'Toy Story, Coco', '2024-01-16',TRUE),
        ('Fantasía', 'Películas ambientadas en mundos irreales', 'Harry Potter, El Señor de los Anillos', '2024-01-17', TRUE),
        ('Documental', 'Películas que representan hechos reales', 'Free Solo, 13th', '2024-01-18', TRUE),
        ('Aventura', 'Películas centradas en viajes y descubrimientos', 'Indiana Jones, Jumanji', '2024-01-19', TRUE);


INSERT INTO usuarios (nombre, apellido, fecha_nacimiento, edad, email, password, role, activo, valoracion) VALUES
        ('Carlos', 'López', '1990-03-15', 34, 'carlos.lopez@example.com', 'clave123', 'usuario', TRUE, 8.5),
        ('María', 'Fernández', '1985-06-22', 39, 'maria.fernandez@example.com', 'maria85', 'admin', TRUE, 9.2),
        ('José', 'Martínez', '1995-12-05', 29, 'jose.martinez@example.com', 'jose95', 'usuario', TRUE, 7.0),
        ('Lucía', 'García', '2000-01-20', 24, 'lucia.garcia@example.com', 'lucia2000', 'usuario', TRUE, 6.8),
        ('Andrés', 'Ramírez', '1992-08-10', 32, 'andres.ramirez@example.com', 'andres92', 'usuario', FALSE, 5.5),
        ('Clara', 'Torres', '1988-04-30', 36, 'clara.torres@example.com', 'clara88', 'admin', TRUE, 9.8),
        ('Pedro', 'Sánchez', '1993-11-12', 31, 'pedro.sanchez@example.com', 'pedrito93', 'usuario', TRUE, 6.2),
        ('Ana', 'Luna', '1997-09-08', 27, 'ana.luna@example.com', 'luna97', 'usuario', TRUE, 7.9),
        ('Miguel', 'Navarro', '1991-05-17', 33, 'miguel.navarro@example.com', 'miguel91', 'usuario', FALSE, 4.3),
        ('Elena', 'Vega', '1983-07-25', 41, 'elena.vega@example.com', 'elena83', 'admin', TRUE, 9.0);


INSERT INTO peliculas (titulo, director, sinopsis, fecha_estreno, imagen, puntuacion, disponible, id_genero) VALUES
        ('Inception', 'Christopher Nolan', 'Un ladrón entra en los sueños de otros para robar ideas.', '2010-07-16', 'inception.jpg', 8.8, true, 4),
        ('Titanic', 'James Cameron', 'Una historia de amor a bordo del Titanic.', '1997-12-19', 'titanic.jpg', 7.8, false, 6),
        ('Toy Story', 'John Lasseter', 'Juguetes que cobran vida cuando los humanos no están.', '1995-11-22', 'toystory.jpg', 8.3, true, 7),
        ('El Conjuro', 'James Wan', 'Investigadores paranormales enfrentan espíritus malignos.', '2013-07-19', 'conjuro.jpg', 7.5, true, 5),
        ('Interestelar', 'Christopher Nolan', 'Viajes espaciales para salvar la humanidad.', '2014-11-07', 'interestelar.jpg', 8.6, true, 4),
        ('El Padrino', 'Francis Ford Coppola', 'Saga mafiosa sobre una familia italiana.', '1972-03-24', 'padrino.jpg', 9.2, false, 3),
        ('Superbad', 'Greg Mottola', 'Dos adolescentes se enfrentan a situaciones locas antes de graduarse.', '2007-08-17', 'superbad.jpg', 7.6, true, 2),
        ('Harry Potter y la Piedra Filosofal', 'Chris Columbus', 'Un niño descubre que es un mago.', '2001-11-16', 'hp1.jpg', 7.6, true, 8),
        ('Rápidos y Furiosos 7', 'James Wan', 'Carreras callejeras y acción sin parar.', '2015-04-03', 'furious7.jpg', 7.1, true, 1),
        ('Free Solo', 'Elizabeth Chai Vasarhelyi', 'Escalador sin cuerdas asciende El Capitán.', '2018-09-28', 'freesolo.jpg', 8.2, false, 9);


INSERT INTO favoritos (id_usuario, id_pelicula, fecha_agregado) VALUES
        (1, 1, '2024-04-01'),
        (1, 3, '2024-04-02'),
        (2, 2, '2024-04-02'),
        (2, 5, '2024-04-03'),
        (3, 4, '2024-04-04'),
        (3, 7, '2024-04-05'),
        (4, 1, '2024-04-06'),
        (4, 8, '2024-04-07'),
        (5, 9, '2024-04-08'),
        (5, 10, '2024-04-09');
