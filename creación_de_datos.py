import time
from faker import Faker
import random
import os
import pandas as pd

# Inicialización de Faker
fake = Faker()

# Definir la cantidad de datos (cambiar aquí según sea necesario)
TOTAL_DATOS = 1000000  # Cambiar a 10000, 100000, o 1000000 según lo desees

# Cantidad de entidades (se ajusta según sea necesario)
USUARIOS = max(1, int(TOTAL_DATOS * 0.20))
VIDEOJUEGOS = max(1, int(TOTAL_DATOS * 0.15))
LOGROS = max(1, int(TOTAL_DATOS * 0.25))
MODS = max(1, int(TOTAL_DATOS * 0.10))
RESEÑAS = max(1, int(TOTAL_DATOS * 0.30))
INTERCAMBIOS = max(1, int(TOTAL_DATOS * 0.20))
OBJETOS = max(1, int(TOTAL_DATOS * 0.15))
EVENTOS = max(1, int(TOTAL_DATOS * 0.10))

# Listas para almacenar los datos generados
usuarios, videojuegos, logros, mods = [], [], [], []
reseñas, intercambios, objetos, eventos = [], [], [], []

# Generación de usuarios
for i in range(USUARIOS):
    rol = random.choice(['Jugador', 'Creador', 'Ambos'])
    usuarios.append({
        'usuario_id': i + 1,
        'nombre': fake.name(),
        'apodo': fake.user_name(),
        'contraseña': fake.password(),
        'fecha_creacion': fake.date_this_decade(),
        'verificado': random.choice([True, False]),
        'rol': rol
    })

# Generación de videojuegos
for i in range(VIDEOJUEGOS):
    videojuego = {
        'id_videojuego': i + 1,
        'nombre': f"Videojuego {fake.word().capitalize()}",
        'descripcion': fake.sentence(),
        'fecha_creacion': fake.date_between(start_date='-5y', end_date='today'),
        'precio': round(random.uniform(10, 60), 2),
        'usuario_id': random.choice(usuarios)['usuario_id']  # Asignando un creador al videojuego
    }
    videojuegos.append(videojuego)

# Generación de logros
for i in range(LOGROS):
    logros.append({
        'id_logro': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],
        'nombre': f"Logro {fake.word().capitalize()}",
        'descripcion': fake.sentence(),
        'dificultad': random.choice(['Fácil', 'Medio', 'Difícil'])
    })

# Generación de mods
for i in range(MODS):
    mods.append({
        'id_mod': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],
        'id_usuario': random.choice(usuarios)['usuario_id'],
        'nombre_mod': f"Mod {fake.word().capitalize()}",
        'fecha_publicacion': fake.date_this_year()
    })

# Generación de objetos
for i in range(OBJETOS):
    objetos.append({
        'objeto_id': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],
        'usuario_id': random.choice(usuarios)['usuario_id'],
        'nombre': f"Objeto {fake.word().capitalize()}",
        'descripcion': fake.sentence(),
        'a_la_venta': random.choice([True, False])
    })

# Generación de reseñas
for i in range(RESEÑAS):
    reseñas.append({
        'reseña_id': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],
        'usuario_id': random.choice(usuarios)['usuario_id'],
        'comentario': fake.paragraph(),
        'fecha_comentario': fake.date_this_year(),
        'nro_logros': random.randint(1, 100),
        'horas_jugadas': random.randint(1, 200)
    })

# Generación de intercambios
for i in range(INTERCAMBIOS):
    intercambios.append({
        'id_intercambio': i + 1,
        'id_objeto': random.choice(objetos)['objeto_id'],
        'usuario_id_dador': random.choice(usuarios)['usuario_id'],
        'usuario_id_recibidor': random.choice(usuarios)['usuario_id'],
        'saldo_dador': round(random.uniform(5, 50), 2),
        'saldo_recibidor': round(random.uniform(5, 50), 2),
        'fecha_transaccion': fake.date_this_year()
    })

# Generación de eventos
for i in range(EVENTOS):
    eventos.append({
        'id_evento': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],
        'nombre': f"Evento {fake.word().capitalize()}",
        'descripcion': fake.sentence(),
        'fecha_inicio': fake.date_this_year(),
        'fecha_fin': fake.date_this_year(),
        'tipo': random.choice(['Promoción', 'Torneo']),
        'activo': random.choice([True, False])
    })

# Función para guardar los datos en archivos CSV con carpetas dinámicas
def save_to_csv(data, filename, total_data):
    folder = f"datos_videojuegos_{total_data}"
    if not os.path.exists(folder):
        os.makedirs(folder)

    filepath = os.path.join(folder, filename)
    pd.DataFrame(data).to_csv(filepath, index=False)
    print(f"{filepath} creado.")

# Medir el tiempo de creación de archivos CSV
start_time = time.time()

# Guardar los datos generados en archivos CSV con las carpetas dinámicas
save_to_csv(usuarios, "usuarios.csv", TOTAL_DATOS)
save_to_csv(videojuegos, "videojuegos.csv", TOTAL_DATOS)
save_to_csv(logros, "logros.csv", TOTAL_DATOS)
save_to_csv(mods, "mods.csv", TOTAL_DATOS)
save_to_csv(reseñas, "reseñas.csv", TOTAL_DATOS)
save_to_csv(intercambios, "intercambios.csv", TOTAL_DATOS)
save_to_csv(objetos, "objetos.csv", TOTAL_DATOS)
save_to_csv(eventos, "eventos.csv", TOTAL_DATOS)

# Generación de Participaciones en eventos
participaciones = []
for evento in eventos:
    for usuario in usuarios:
        participaciones.append({
            'usuario_id': usuario['usuario_id'],
            'id_evento': evento['id_evento'],
            'fecha_participacion': fake.date_this_year(),
            'rol': random.choice(['Participante', 'Espectador'])
        })

# Guardar las participaciones
save_to_csv(participaciones, "participaciones.csv", TOTAL_DATOS)

# Calcular el tiempo transcurrido
end_time = time.time()
execution_time = end_time - start_time
print(f"Tiempo total para generar los archivos CSV: {execution_time:.2f} segundos")