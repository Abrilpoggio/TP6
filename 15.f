import random

class Maravilla:
    def __init__(self, nombre, paises, tipo):
        self.nombre = nombre
        self.paises = paises
        self.tipo = tipo


class Grafo:
    def __init__(self):
        self.vertices = {}    # Almacena las maravillas
        self.aristas = {}     # Almacena las conexiones con distancias

    def agregar_maravilla(self, maravilla):
        if maravilla.nombre not in self.vertices:
            self.vertices[maravilla.nombre] = maravilla
            self.aristas[maravilla.nombre] = []
        else:
            print(f"La maravilla {maravilla.nombre} ya existe en el grafo.")

    def conectar_maravillas_mismo_tipo(self):
        # Divide las maravillas por tipo y conecta las del mismo tipo con distancias aleatorias
        maravillas_por_tipo = {'arquitectónica': [], 'natural': []}
        for maravilla in self.vertices.values():
            maravillas_por_tipo[maravilla.tipo].append(maravilla)

        for tipo, maravillas in maravillas_por_tipo.items():
            for i, maravilla1 in enumerate(maravillas):
                for j in range(i + 1, len(maravillas)):
                    maravilla2 = maravillas[j]
                    distancia = random.randint(100, 5000)  # Distancia en kilómetros
                    # Conexión bidireccional
                    self.aristas[maravilla1.nombre].append((maravilla2.nombre, distancia))
                    self.aristas[maravilla2.nombre].append((maravilla1.nombre, distancia))

    def encontrar_paises_con_ambos_tipos(self):
        # Método para encontrar países con maravillas de ambos tipos
        paises_arquitectonicas = set()
        paises_naturales = set()

        for maravilla in self.vertices.values():
            if maravilla.tipo == "arquitectónica":
                paises_arquitectonicas.update(maravilla.paises)
            elif maravilla.tipo == "natural":
                paises_naturales.update(maravilla.paises)

        # Intersección para encontrar países con ambos tipos de maravillas
        paises_con_ambos_tipos = paises_arquitectonicas.intersection(paises_naturales)

        if paises_con_ambos_tipos:
            print("Países con maravillas arquitectónicas y naturales:")
            for pais in paises_con_ambos_tipos:
                print(f"  - {pais}")
        else:
            print("No hay países con maravillas arquitectónicas y naturales.")

    def encontrar_paises_con_varias_maravillas_mismo_tipo(self):
        # Diccionarios para almacenar el conteo de maravillas por país
        contador_maravillas = {
            'arquitectónica': {},
            'natural': {}
        }

        for maravilla in self.vertices.values():
            for pais in maravilla.paises:
                if maravilla.tipo == "arquitectónica":
                    if pais not in contador_maravillas['arquitectónica']:
                        contador_maravillas['arquitectónica'][pais] = 0
                    contador_maravillas['arquitectónica'][pais] += 1
                elif maravilla.tipo == "natural":
                    if pais not in contador_maravillas['natural']:
                        contador_maravillas['natural'][pais] = 0
                    contador_maravillas['natural'][pais] += 1

        # Mostrar países con más de una maravilla del mismo tipo
        for tipo in contador_maravillas:
            print(f"Países con más de una maravilla {tipo}:")
            for pais, conteo in contador_maravillas[tipo].items():
                if conteo > 1:
                    print(f"  - {pais}: {conteo} maravillas")

# Crear el grafo y añadir maravillas
maravillas_grafo = Grafo()

# Maravillas arquitectónicas
maravillas_grafo.agregar_maravilla(Maravilla("Chichén Itzá", ["México"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Cristo Redentor", ["Brasil"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Coliseo", ["Italia"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Gran Muralla China", ["China"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Machu Picchu", ["Perú"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Petra", ["Jordania"], "arquitectónica"))
maravillas_grafo.agregar_maravilla(Maravilla("Taj Mahal", ["India"], "arquitectónica"))

# Maravillas naturales
maravillas_grafo.agregar_maravilla(Maravilla("Cataratas del Iguazú", ["Argentina", "Brasil"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Amazonas", ["Brasil", "Perú", "Colombia", "Venezuela", "Ecuador", "Bolivia", "Guyana", "Surinam"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Bahía de Ha Long", ["Vietnam"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Isla Jeju", ["Corea del Sur"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Parque Nacional de Komodo", ["Indonesia"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Río Subterráneo de Puerto Princesa", ["Filipinas"], "natural"))
maravillas_grafo.agregar_maravilla(Maravilla("Montaña de la Mesa", ["Sudáfrica"], "natural"))

# Conectar maravillas del mismo tipo
maravillas_grafo.conectar_maravillas_mismo_tipo()

# Encontrar y mostrar países con maravillas de ambos tipos
maravillas_grafo.encontrar_paises_con_ambos_tipos()

# Encontrar y mostrar países con más de una maravilla del mismo tipo
maravillas_grafo.encontrar_paises_con_varias_maravillas_mismo_tipo()
