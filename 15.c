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
                    self.aristas[maravilla1.nombre].append((maravilla2.nombre, distancia))
                    self.aristas[maravilla2.nombre].append((maravilla1.nombre, distancia))

    def obtener_arbol_expansion_minimo(self, tipo):
        # Filtra aristas solo para el tipo de maravilla indicado
        aristas_tipo = []
        for vertice, conexiones in self.aristas.items():
            if self.vertices[vertice].tipo == tipo:
                for destino, distancia in conexiones:
                    if self.vertices[destino].tipo == tipo:
                        aristas_tipo.append((distancia, vertice, destino))

        # Ordena las aristas por distancia (peso)
        aristas_tipo.sort()

        # Inicialización para el MST usando el algoritmo de Kruskal
        mst = []
        padre = {}
        rango = {}

        # Funciones auxiliares para Union-Find
        def find(nodo):
            if padre[nodo] != nodo:
                padre[nodo] = find(padre[nodo])
            return padre[nodo]

        def union(nodo1, nodo2):
            raiz1 = find(nodo1)
            raiz2 = find(nodo2)
            if raiz1 != raiz2:
                if rango[raiz1] > rango[raiz2]:
                    padre[raiz2] = raiz1
                else:
                    padre[raiz1] = raiz2
                    if rango[raiz1] == rango[raiz2]:
                        rango[raiz2] += 1

        # Inicializa el conjunto de cada vértice para Union-Find
        for maravilla in [m for m in self.vertices.values() if m.tipo == tipo]:
            padre[maravilla.nombre] = maravilla.nombre
            rango[maravilla.nombre] = 0

        # Aplicar Kruskal
        for distancia, vertice1, vertice2 in aristas_tipo:
            if find(vertice1) != find(vertice2):
                union(vertice1, vertice2)
                mst.append((vertice1, vertice2, distancia))

        # Calcular la distancia total del MST y mostrar el resultado
        distancia_total = sum(distancia for _, _, distancia in mst)
        print(f"Árbol de expansión mínima para maravillas {tipo}:")
        for vertice1, vertice2, distancia in mst:
            print(f"  - Conexión entre {vertice1} y {vertice2} a {distancia} km")
        print(f"Distancia total: {distancia_total} km\n")

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

# Obtener y mostrar el MST para cada tipo de maravilla
maravillas_grafo.obtener_arbol_expansion_minimo("arquitectónica")
maravillas_grafo.obtener_arbol_expansion_minimo("natural")
