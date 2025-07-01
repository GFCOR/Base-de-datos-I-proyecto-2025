import pandas as pd
from faker import Faker
import random
import os

# Inicialización
fake = Faker()
Faker.seed(0)
random.seed(0)

TOTAL_DATOS = 1000000

USUARIOS = max(1, int(TOTAL_DATOS * 0.20))
VIDEOJUEGOS = max(1, int(TOTAL_DATOS * 0.15))
LOGROS = max(1, int(TOTAL_DATOS * 0.25))
MODS = max(1, int(TOTAL_DATOS * 0.10))
OBJETOS = max(1, int(TOTAL_DATOS * 0.15))
RESEÑAS = max(1, int(TOTAL_DATOS * 0.30))
INTERCAMBIOS = max(1, int(TOTAL_DATOS * 0.20))
EVENTOS = max(1, int(TOTAL_DATOS * 0.10))

usuarios = [{
    'usuario_id': i + 1,
    'nombre': fake.name()[:255],
    'apodo': fake.user_name()[:255],
    'contraseña': fake.password()[:255],
    'fecha_creacion': fake.date_between(start_date='-5y', end_date='today').isoformat(),
    'verificado': random.choice([True, False]),
    'rol': random.choice(['Jugador', 'Creador', 'Ambos'])
} for i in range(USUARIOS)]

usuario_ids = [u['usuario_id'] for u in usuarios]

videojuegos = [{
    'id_videojuego': i + 1,
    'nombre': f"Videojuego {fake.word().capitalize()}"[:255],
    'descripcion': fake.sentence(),
    'fecha_creacion': fake.date_between(start_date='-5y', end_date='today').isoformat(),
    'precio': round(random.uniform(10, 60), 2),
    'usuario_id': random.choice(usuario_ids)
} for i in range(VIDEOJUEGOS)]

videojuego_ids = [v['id_videojuego'] for v in videojuegos]

logros = [{
    'id_logro': i + 1,
    'id_videojuego': random.choice(videojuego_ids),
    'nombre': f"Logro {fake.word().capitalize()}",
    'descripcion': fake.sentence(),
    'dificultad': random.choice(['Fácil', 'Medio', 'Difícil'])
} for i in range(LOGROS)]

mods = [{
    'id_mod': i + 1,
    'id_videojuego': random.choice(videojuego_ids),
    'id_usuario': random.choice(usuario_ids),
    'nombre_mod': f"Mod {fake.word().capitalize()}",
    'fecha_publicacion': fake.date_this_year().isoformat()
} for i in range(MODS)]

objetos = [{
    'objeto_id': i + 1,
    'id_videojuego': random.choice(videojuego_ids),
    'usuario_id': random.choice(usuario_ids),
    'nombre': f"Objeto {fake.word().capitalize()}",
    'descripcion': fake.sentence(),
    'a_la_venta': random.choice([True, False])
} for i in range(OBJETOS)]

objetos_ids = [o['objeto_id'] for o in objetos]

reseñas = [{
    'reseña_id': i + 1,
    'id_videojuego': random.choice(videojuego_ids),
    'usuario_id': random.choice(usuario_ids),
    'comentario': fake.paragraph(),
    'fecha_comentario': fake.date_this_year().isoformat(),
    'nro_logros': random.randint(1, 100),
    'horas_jugadas': random.randint(1, 200)
} for i in range(RESEÑAS)]

intercambios = [{
    'id_intercambio': i + 1,
    'id_objeto': random.choice(objetos_ids),
    'usuario_id_dador': random.choice(usuario_ids),
    'usuario_id_recibidor': random.choice(usuario_ids),
    'saldo_dador': round(random.uniform(5, 50), 2),
    'saldo_recibidor': round(random.uniform(5, 50), 2),
    'fecha_transaccion': fake.date_this_year().isoformat()
} for i in range(INTERCAMBIOS)]

eventos = [{
    'id_evento': i + 1,
    'id_videojuego': random.choice(videojuego_ids),
    'nombre': f"Evento {fake.word().capitalize()}",
    'descripcion': fake.sentence(),
    'fecha_inicio': fake.date_this_year().isoformat(),
    'fecha_fin': fake.date_this_year().isoformat(),
    'tipo': random.choice(['Promoción', 'Torneo']),
    'activo': random.choice([True, False])
} for i in range(EVENTOS)]

# Guardar a CSV

def save_to_csv(data, filename):
    folder = "datos_videojuegos_1000000"
    if not os.path.exists(folder):
        os.makedirs(folder)
    filepath = os.path.join(folder, filename)
    pd.DataFrame(data).to_csv(filepath, index=False)
    print(f"{filepath} creado.")

save_to_csv(usuarios, "usuarios.csv")
save_to_csv(videojuegos, "videojuegos.csv")
save_to_csv(logros, "logros.csv")
save_to_csv(mods, "mods.csv")
save_to_csv(objetos, "objetos.csv")
save_to_csv(reseñas, "reseñas.csv")
save_to_csv(intercambios, "intercambios.csv")
save_to_csv(eventos, "eventos.csv")
