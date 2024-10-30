import heapq

class Grafo:
    def __init__(self):
        self.grafo = {}
        self.aristas = []

    def agregar_vertice(self, vertice):
        if vertice not in self.grafo:
            self.grafo[vertice] = []

    def agregar_arista(self, vertice1, vertice2, peso):
        if vertice1 in self.grafo and vertice2 in self.grafo:
            self.grafo[vertice1].append((vertice2, peso))
            self.grafo[vertice2].append((vertice1, peso))
            self.aristas.append((peso, vertice1, vertice2))

    def camino_mas_corto(self, inicio, destino):
        # Inicializar distancias infinitas excepto para el nodo de inicio
        distancias = {vertice: float('inf') for vertice in self.grafo}
        distancias[inicio] = 0

        # Cola de prioridad para almacenar los vértices por distancia acumulada
        cola_prioridad = [(0, inicio)]
        # Rastro de camino para reconstruir la ruta final
        rastro = {inicio: None}

        while cola_prioridad:
            distancia_actual, vertice_actual = heapq.heappop(cola_prioridad)

            if vertice_actual == destino:
                break

            # Explorar vecinos y actualizar distancias
            for vecino, peso in self.grafo[vertice_actual]:
                distancia = distancia_actual + peso
                if distancia < distancias[vecino]:
                    distancias[vecino] = distancia
                    rastro[vecino] = vertice_actual
                    heapq.heappush(cola_prioridad, (distancia, vecino))

        # Reconstruir el camino desde el destino al inicio
        camino = []
        vertice = destino
        while vertice is not None:
            camino.append(vertice)
            vertice = rastro[vertice]
        camino.reverse()  # Invertir el camino para mostrarlo en orden desde inicio a destino

        return camino, distancias[destino]

# Crear el grafo y añadir los vértices y aristas
casa = Grafo()
ambientes = ["cocina", "comedor", "cochera", "quincho", "baño 1", "baño 2", 
             "habitación 1", "habitación 2", "sala de estar", "terraza", "patio"]

for ambiente in ambientes:
    casa.agregar_vertice(ambiente)

# Definir conexiones y pesos aleatorios entre 3 y 30 metros
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

# Asignar conexiones con pesos en metros
for v1, v2 in conexiones:
    peso = random.randint(3, 30)
    casa.agregar_arista(v1, v2, peso)

# Encontrar el camino más corto de "habitación 1" a "sala de estar" y calcular la distancia
camino, distancia_total = casa.camino_mas_corto("habitación 1", "sala de estar")

# Mostrar el resultado
print("Camino más corto de 'habitación 1' a 'sala de estar':", " -> ".join(camino))
print(f"Longitud total de cable necesaria: {distancia_total} metros")
