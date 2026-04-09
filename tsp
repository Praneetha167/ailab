from itertools import permutations

# Graph represented as an adjacency matrix
graph = [
    [0, 10, 15, 20],
    [10, 0, 35, 25],
    [15, 35, 0, 30],
    [20, 25, 30, 0]
]

n = len(graph)
cities = list(range(n))
min_path = float('inf')

# Generate all permutations of cities except the starting city (0)
for perm in permutations(cities[1:]):
    cost = 0
    k = 0  # Start from city 0
    for j in perm:
        cost += graph[k][j]
        k = j
    cost += graph[k][0]  # Return to starting city
    min_path = min(min_path, cost)

print("Minimum cost:", min_path)



-------------------------------------------------------------------------------------------------------------------


  from itertools import permutations

# -----------------------
# User input for the graph
# -----------------------
n = int(input("Enter the number of cities: "))

graph = []
print("Enter the distance matrix row by row (space-separated):")
for i in range(n):
    row = list(map(int, input(f"Row {i + 1}: ").split()))
    if len(row) != n:
        raise ValueError(f"Row {i + 1} must have exactly {n} numbers.")
    graph.append(row)

# -----------------------
# Brute-force TSP using permutations
# -----------------------
cities = list(range(n))
min_path = float('inf')

for perm in permutations(cities[1:]):  # Fix city 0 as starting point
    cost = 0
    k = 0  # Start from city 0
    for j in perm:
        cost += graph[k][j]
        k = j
    cost += graph[k][0]  # Return to starting city
    min_path = min(min_path, cost)

print("Minimum cost of visiting all cities:", min_path)



------------------------------------------------------------------------------------------

from itertools import combinations

# Graph (same as yours)
graph = [
    [0, 10, 15, 20],
    [10, 0, 35, 25],
    [15, 35, 0, 30],
    [20, 25, 30, 0]
]

n = len(graph)

# dp[(mask, i)] = minimum cost to reach city i with visited set "mask"
dp = {}

# Base case: start from city 0
for i in range(1, n):
    dp[(1 << i, i)] = graph[0][i]

# Build DP table
for r in range(2, n):
    for subset in combinations(range(1, n), r):
        mask = 0
        for bit in subset:
            mask |= (1 << bit)

        for j in subset:
            prev_mask = mask ^ (1 << j)
            min_cost = float('inf')

            for k in subset:
                if k != j:
                    cost = dp[(prev_mask, k)] + graph[k][j]
                    min_cost = min(min_cost, cost)

            dp[(mask, j)] = min_cost

# Final step: return to city 0
full_mask = (1 << n) - 2  # exclude city 0
min_path = float('inf')

for i in range(1, n):
    cost = dp[(full_mask, i)] + graph[i][0]
    min_path = min(min_path, cost)

print("Minimum cost:", min_path)
