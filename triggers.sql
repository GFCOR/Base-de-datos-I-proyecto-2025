-- 1. Trigger para actualizar el estado 'verificado' de un Usuario cuando se añade una nueva Reseña
CREATE OR REPLACE FUNCTION actualizar_verificado_usuario()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE steam_db.steam_project.usuarios
    SET verificado = TRUE
    WHERE usuario_id = NEW.usuario_id AND (
                                              SELECT COUNT(*) FROM steam_db.steam_project.reseñas WHERE usuario_id = NEW.usuario_id
                                          ) > 5;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_verificado_usuario
    AFTER INSERT ON steam_db.steam_project.reseñas
    FOR EACH ROW
EXECUTE FUNCTION actualizar_verificado_usuario();

-- 2. Trigger para actualizar el 'precio' de un Videojuego cuando se añade un nuevo Mod
CREATE OR REPLACE FUNCTION actualizar_precio_videojuego()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE steam_db.steam_project.videojuegos
    SET precio = precio * 1.10
    WHERE id_videojuego = NEW.id_videojuego;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_precio_videojuego
    AFTER INSERT ON steam_db.steam_project.mods
    FOR EACH ROW
EXECUTE FUNCTION actualizar_precio_videojuego();

-- 3. Trigger para actualizar la 'fecha_creación' de un Videojuego cuando se añade un nuevo Logro
CREATE OR REPLACE FUNCTION actualizar_fecha_creacion_videojuego()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE steam_db.steam_project.videojuegos
    SET fecha_creacion = CURRENT_DATE
    WHERE id_videojuego = NEW.id_videojuego;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_fecha_creacion_videojuego
    AFTER INSERT ON steam_db.steam_project.logros
    FOR EACH ROW
EXECUTE FUNCTION actualizar_fecha_creacion_videojuego();

-- 4. Trigger para validar el 'saldo_recibir' y 'saldo_dado' en Intercambios
CREATE OR REPLACE FUNCTION validar_saldo_intercambios()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.saldo_recibir > NEW.saldo_dado THEN
        RAISE EXCEPTION 'El saldo a recibir no puede ser mayor que el saldo dado';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_saldo_intercambios
    BEFORE INSERT OR UPDATE ON steam_db.steam_project.intercambios
    FOR EACH ROW
EXECUTE FUNCTION validar_saldo_intercambios();

-- 5. Trigger para asegurarse de que el usuario existe antes de agregar un nuevo Videojuego
CREATE OR REPLACE FUNCTION check_videojuego_usuario_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.usuarios WHERE usuario_id = NEW.usuario_id) THEN
        RAISE EXCEPTION 'El usuario con id % no existe', NEW.usuario_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_videojuego_usuario_exists
    BEFORE INSERT ON steam_db.steam_project.videojuegos
    FOR EACH ROW
EXECUTE FUNCTION check_videojuego_usuario_exists();

-- 6. Trigger para asegurar que el videojuego relacionado en Mods exista
CREATE OR REPLACE FUNCTION check_mod_videojuego_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.videojuegos WHERE id_videojuego = NEW.id_videojuego) THEN
        RAISE EXCEPTION 'El videojuego con id % no existe', NEW.id_videojuego;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_mod_videojuego_exists
    BEFORE INSERT ON steam_db.steam_project.mods
    FOR EACH ROW
EXECUTE FUNCTION check_mod_videojuego_exists();

-- 7. Trigger para asegurar que el videojuego relacionado en Objetos exista
CREATE OR REPLACE FUNCTION check_objeto_videojuego_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.videojuegos WHERE id_videojuego = NEW.id_videojuego) THEN
        RAISE EXCEPTION 'El videojuego con id % no existe', NEW.id_videojuego;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_objeto_videojuego_exists
    BEFORE INSERT ON steam_db.steam_project.objetos
    FOR EACH ROW
EXECUTE FUNCTION check_objeto_videojuego_exists();

-- 8. Trigger para validar que el usuario existe antes de agregar una Reseña
CREATE OR REPLACE FUNCTION check_reseña_usuario_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.usuarios WHERE usuario_id = NEW.usuario_id) THEN
        RAISE EXCEPTION 'El usuario con id % no existe', NEW.usuario_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_reseña_usuario_exists
    BEFORE INSERT ON steam_db.steam_project.reseñas
    FOR EACH ROW
EXECUTE FUNCTION check_reseña_usuario_exists();

-- 9. Trigger para asegurar que el objeto relacionado en Intercambios exista
CREATE OR REPLACE FUNCTION check_intercambio_objeto_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.objetos WHERE objeto_id = NEW.id_objeto) THEN
        RAISE EXCEPTION 'El objeto con id % no existe', NEW.id_objeto;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_intercambio_objeto_exists
    BEFORE INSERT ON steam_db.steam_project.intercambios
    FOR EACH ROW
EXECUTE FUNCTION check_intercambio_objeto_exists();

-- 10. Trigger para asegurar que el videojuego relacionado en Eventos exista
CREATE OR REPLACE FUNCTION check_evento_videojuego_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM steam_db.steam_project.videojuegos WHERE id_videojuego = NEW.id_videojuego) THEN
        RAISE EXCEPTION 'El videojuego con id % no existe', NEW.id_videojuego;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_evento_videojuego_exists
    BEFORE INSERT ON steam_db.steam_project.eventos
    FOR EACH ROW
EXECUTE FUNCTION check_evento_videojuego_exists();

