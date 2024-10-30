import random

class Maravilla:
    def __init__(self, nombre, paises, tipo):
        self.nombre = nombre
        self.paises = paises
        self.tipo = tipo

    def __repr__(self):
        return f"{self.nombre} ({self.tipo}) - Ubicación: {', '.join(self.paises)}"


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
        # Dividir maravillas por tipo
        maravillas_por_tipo = {'arquitectónica': [], 'natural': []}
        for maravilla in self.vertices.values():
            maravillas_por_tipo[maravilla.tipo].append(maravilla)

        # Crear conexiones entre maravillas del mismo tipo con distancias aleatorias
        for tipo, maravillas in maravillas_por_tipo.items():
            for i, maravilla1 in enumerate(maravillas):
                for j in range(i + 1, len(maravillas)):
                    maravilla2 = maravillas[j]
                    distancia = random.randint(100, 5000)  # Distancia en kilómetros
                    self.aristas[maravilla1.nombre].append((maravilla2.nombre, distancia))
                    self.aristas[maravilla2.nombre].append((maravilla1.nombre, distancia))

    def mostrar_conexiones(self):
        # Mostrar las conexiones con distancias
        for maravilla, conexiones in self.aristas.items():
            print(f"Conexiones de {maravilla}:")
            for destino, distancia in conexiones:
                print(f"  - {destino} a {distancia} km")


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

# Mostrar las conexiones y distancias
maravillas_grafo.mostrar_conexiones()
