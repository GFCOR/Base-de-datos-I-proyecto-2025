-- 1. Restricción para la tabla Usuarios (fecha_creacion debe ser anterior a la fecha actual)
ALTER TABLE steam_project.usuarios
    ADD CONSTRAINT check_fecha_creacion CHECK (fecha_creacion <= CURRENT_DATE);

-- 2. Restricción para la tabla Usuarios (rol debe ser 'Jugador', 'Creador' o 'Ambos')
ALTER TABLE steam_project.usuarios
    ADD CONSTRAINT check_rol CHECK (rol IN ('Jugador', 'Creador', 'Ambos'));

-- 3. Restricción para la tabla Videojuegos (precio debe ser mayor que 0)
ALTER TABLE steam_project.videojuegos
    ADD CONSTRAINT check_precio CHECK (precio > 0);

-- 4. Restricción para la tabla Videojuegos (usuario_id debe existir en la tabla de usuarios)
ALTER TABLE steam_project.videojuegos
    ADD CONSTRAINT fk_videojuego_usuario FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id);

-- 5. Restricción para la tabla Logros (id_videojuego debe existir en la tabla de videojuegos)
ALTER TABLE steam_project.logros
    ADD CONSTRAINT fk_logro_videojuego FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego);

-- 6. Restricción para la tabla Mods (id_videojuego y id_usuario deben existir)
ALTER TABLE steam_project.mods
    ADD CONSTRAINT fk_mod_videojuego FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),
    ADD CONSTRAINT fk_mod_usuario FOREIGN KEY (id_usuario) REFERENCES steam_project.usuarios(usuario_id);

-- 7. Restricción para la tabla Objetos (id_videojuego y usuario_id deben existir, y a_la_venta debe ser booleano)
ALTER TABLE steam_project.objetos
    ADD CONSTRAINT fk_objeto_videojuego FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),
    ADD CONSTRAINT fk_objeto_usuario FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id),
    ADD CONSTRAINT check_a_la_venta CHECK (a_la_venta IN (TRUE, FALSE));

-- 8. Restricción para la tabla Reseñas (id_videojuego y usuario_id deben existir, y horas_jugadas debe ser positivo)
ALTER TABLE steam_project.reseñas
    ADD CONSTRAINT fk_reseña_videojuego FOREIGN KEY (id_videojuego) REFERENCES steam_project.videojuegos(id_videojuego),
    ADD CONSTRAINT fk_reseña_usuario FOREIGN KEY (usuario_id) REFERENCES steam_project.usuarios(usuario_id),
    ADD CONSTRAINT check_horas_jugadas CHECK (horas_jugadas >= 0);

-- 9. Restricción para la tabla Intercambios (id_objeto, usuario_id_dador, usuario_id_recibidor deben existir, y los saldos deben ser positivos)
ALTER TABLE steam_project.intercambios
    ADD CONSTRAINT fk_intercambio_objeto FOREIGN KEY (id_objeto) REFERENCES steam_project.objetos(objeto_id),
    ADD CONSTRAINT fk_intercambio_usuario_dador FOREIGN KEY (usuario_id_dador) REFERENCES steam_project.usuarios(usuario_id),
    ADD CONSTRAINT fk_intercambio_usuario_recibidor FOREIGN KEY (usuario_id_recibidor) REFERENCES steam_project.usuarios(usuario_id),
    ADD CONSTRAINT check_saldo_dador CHECK (saldo_dador > 0),
    ADD CONSTRAINT check_saldo_recibidor CHECK (saldo_recibidor > 0);

