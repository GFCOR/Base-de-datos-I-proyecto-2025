-- 1. Tabla de Usuarios
CREATE TABLE steam_project.usuarios (
                                        usuario_id SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                        nombre VARCHAR(255),
                                        apodo VARCHAR(255),
                                        contraseña VARCHAR(255),
                                        fecha_creacion DATE,
                                        verificado BOOLEAN,
                                        rol VARCHAR(50)  -- Valores posibles: Jugador, Creador, Ambos
);

-- 2. Tabla de Videojuegos
CREATE TABLE steam_project.videojuegos (
                                           id_videojuego SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                           nombre VARCHAR(255),
                                           descripcion TEXT,
                                           fecha_creacion DATE,
                                           precio NUMERIC(5,2),
                                           usuario_id INT,  -- Clave foránea que hace referencia a usuarios
                                           FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id)  -- Relación con la tabla de usuarios
);

-- 3. Tabla de Logros
CREATE TABLE steam_project.logros (
                                      id_logro SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                      id_videojuego INT,  -- Clave foránea que hace referencia a videojuegos
                                      nombre VARCHAR(255),
                                      descripcion TEXT,
                                      dificultad VARCHAR(50),
                                      FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego)  -- Relación con la tabla de videojuegos
);

-- 4. Tabla de Mods
CREATE TABLE steam_project.mods (
                                    id_mod SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                    id_videojuego INT,  -- Clave foránea que hace referencia a videojuegos
                                    id_usuario INT,  -- Clave foránea que hace referencia a usuarios
                                    nombre_mod VARCHAR(255),
                                    fecha_publicacion DATE,
                                    FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),  -- Relación con la tabla de videojuegos
                                    FOREIGN KEY (id_usuario) REFERENCES steam_project.usuarios(usuario_id)  -- Relación con la tabla de usuarios
);

-- 5. Tabla de Objetos
CREATE TABLE steam_project.objetos (
                                       objeto_id SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                       id_videojuego INT,  -- Clave foránea que hace referencia a videojuegos
                                       usuario_id INT,  -- Clave foránea que hace referencia a usuarios
                                       nombre VARCHAR(255),
                                       descripcion TEXT,
                                       a_la_venta BOOLEAN,
                                       FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),  -- Relación con la tabla de videojuegos
                                       FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id)  -- Relación con la tabla de usuarios
);

-- 6. Tabla de Reseñas
CREATE TABLE steam_project.reseñas (
                                       reseña_id SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                       id_videojuego INT,  -- Clave foránea que hace referencia a videojuegos
                                       usuario_id INT,  -- Clave foránea que hace referencia a usuarios
                                       comentario TEXT,
                                       fecha_comentario DATE,
                                       nro_logros INT,
                                       horas_jugadas INT,
                                       FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),  -- Relación con la tabla de videojuegos
                                       FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id)  -- Relación con la tabla de usuarios
);

-- 7. Tabla de Intercambios
CREATE TABLE steam_project.intercambios (
                                            id_intercambio SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                            id_objeto INT,  -- Clave foránea que hace referencia a objetos
                                            usuario_id_dador INT,  -- Clave foránea que hace referencia a usuarios (dador)
                                            usuario_id_recibidor INT,  -- Clave foránea que hace referencia a usuarios (recibidor)
                                            saldo_dador NUMERIC(5,2),
                                            saldo_recibidor NUMERIC(5,2),
                                            fecha_transaccion DATE,
                                            FOREIGN KEY (id_objeto) REFERENCES steam_project.objetos(objeto_id),  -- Relación con la tabla de objetos
                                            FOREIGN KEY (usuario_id_dador) REFERENCES steam_project.usuarios(usuario_id),  -- Relación con la tabla de usuarios
                                            FOREIGN KEY (usuario_id_recibidor) REFERENCES steam_project.usuarios(usuario_id)  -- Relación con la tabla de usuarios
);

-- 8. Tabla de Eventos
CREATE TABLE steam_project.eventos (
                                       id_evento SERIAL PRIMARY KEY,  -- Clave primaria de la tabla
                                       id_videojuego INT,  -- Clave foránea que hace referencia a videojuegos
                                       nombre VARCHAR(255),
                                       descripcion TEXT,
                                       fecha_inicio DATE,
                                       fecha_fin DATE,
                                       tipo VARCHAR(50),  -- Valores posibles: Promoción, Torneo
                                       activo BOOLEAN,
                                       FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego)  -- Relación con la tabla de videojuegos
);

