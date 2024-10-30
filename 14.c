import random

class Grafo:
    def __init__(self):
        self.grafo = {}
        self.aristas = []  # Lista para almacenar las aristas con sus pesos

    def agregar_vertice(self, vertice):
        if vertice not in self.grafo:
            self.grafo[vertice] = []

    def agregar_arista(self, vertice1, vertice2, peso):
        if vertice1 in self.grafo and vertice2 in self.grafo:
            # Agregar arista en ambos vértices para un grafo no dirigido
            self.grafo[vertice1].append((vertice2, peso))
            self.grafo[vertice2].append((vertice1, peso))
            # Agregar la arista en la lista de aristas para el cálculo de MST
            self.aristas.append((peso, vertice1, vertice2))

    def obtener_arbol_expansion_minima(self):
        # Usaremos el algoritmo de Kruskal para obtener el MST
        mst = []
        total_peso = 0

        # Ordenar las aristas por peso
        self.aristas.sort()

        # Inicializar estructura de conjuntos disjuntos (Union-Find)
        padre = {}
        for vertice in self.grafo:
            padre[vertice] = vertice

        # Funciones auxiliares para Union-Find
        def encontrar(vertice):
            if padre[vertice] != vertice:
                padre[vertice] = encontrar(padre[vertice])
            return padre[vertice]

        def union(vertice1, vertice2):
            raiz1 = encontrar(vertice1)
            raiz2 = encontrar(vertice2)
            if raiz1 != raiz2:
                padre[raiz2] = raiz1

        # Algoritmo de Kruskal
        for peso, vertice1, vertice2 in self.aristas:
            if encontrar(vertice1) != encontrar(vertice2):
                union(vertice1, vertice2)
                mst.append((vertice1, vertice2, peso))
                total_peso += peso

        return mst, total_peso

# Crear el grafo y añadir vértices y aristas
casa = Grafo()

# Agregar los vértices (ambientes)
ambientes = ["cocina", "comedor", "cochera", "quincho", "baño 1", "baño 2", 
             "habitación 1", "habitación 2", "sala de estar", "terraza", "patio"]

for ambiente in ambientes:
    casa.agregar_vertice(ambiente)

# Definir conexiones con al menos 3 aristas por vértice y 5 en dos vértices
conexiones = [
    ("cocina", "comedor"), ("cocina", "terraza"), ("cocina", "sala de estar"), ("cocina", "baño 1"), ("cocina", "patio"),
    ("comedor", "sala de estar"), ("comedor", "baño 1"), ("comedor", "cocina"),
    ("sala de estar", "habitación 1"), ("sala de estar", "habitación 2"), ("sala de estar", "terraza"), ("sala de estar", "cocina"), ("sala de estar", "patio"),
    ("cochera", "quincho"), ("cochera", "patio"), ("cochera", "cocina"),
    ("terraza", "patio"), ("terraza", "habitación 2"), ("terraza", "baño 2"),
    ("baño 1", "habitación 1"), ("baño 1", "comedor"), ("baño 1", "cocina"),
    ("baño 2", "habitación 2"), ("baño 2", "terraza"),
    ("quincho", "patio"), ("quincho", "terraza"), ("quincho", "cocina")
]

# Asignar las conexiones en el grafo con pesos aleatorios entre 3 y 30 metros
for v1, v2 in conexiones:
    peso = random.randint(3, 30)  # Peso en metros
    casa.agregar_arista(v1, v2, peso)

# Obtener el árbol de expansión mínima (MST) y la longitud total de cable necesaria
mst, total_peso = casa.obtener_arbol_expansion_minima()

# Mostrar el resultado
print("Aristas en el árbol de expansión mínima (MST):")
for v1, v2, peso in mst:
    print(f"{v1} -- {peso}m --> {v2}")

print(f"\nLongitud total de cable necesaria: {total_peso} metros")
