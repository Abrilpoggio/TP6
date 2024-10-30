import random

class Grafo:
    def __init__(self):
        # Diccionario para almacenar los vértices y sus conexiones con pesos
        self.grafo = {}

    def agregar_vertice(self, vertice):
        if vertice not in self.grafo:
            self.grafo[vertice] = []

    def agregar_arista(self, vertice1, vertice2, peso):
        # Agregar una arista con peso a ambos vértices (grafo no dirigido)
        if vertice1 in self.grafo and vertice2 in self.grafo:
            self.grafo[vertice1].append((vertice2, peso))
            self.grafo[vertice2].append((vertice1, peso))

    def adyacentes(self, vertice):
        # Retornar los vértices adyacentes con los pesos de cada arista
        return self.grafo.get(vertice, [])

# Creación del grafo
casa = Grafo()

# Agregar los vértices (ambientes)
ambientes = ["cocina", "comedor", "cochera", "quincho", "baño 1", "baño 2", 
             "habitación 1", "habitación 2", "sala de estar", "terraza", "patio"]

for ambiente in ambientes:
    casa.agregar_vertice(ambiente)

# Definir conexiones, asegurando al menos 3 conexiones por vértice y 5 para dos vértices
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

# Asignar las conexiones con pesos aleatorios entre 3 y 30 metros
for v1, v2 in conexiones:
    peso = random.randint(3, 30)  # Distancia en metros
    casa.agregar_arista(v1, v2, peso)

# Ejemplo de uso:
print("Ambientes adyacentes a la cocina con distancias:", casa.adyacentes("cocina"))
print("Ambientes adyacentes a la sala de estar con distancias:", casa.adyacentes("sala de estar"))
