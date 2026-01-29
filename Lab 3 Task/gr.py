from collections import deque

# -----------------------------
# Breadth First Search (BFS)
# -----------------------------
def bfs(graph, start, goal):
    queue = deque([start])
    visited = set([start])
    parent = {start: None}

    while queue:
        current = queue.popleft()

        if current == goal:
            return reconstruct_path(parent, goal)

        for neighbor in graph[current]:
            if neighbor not in visited:
                visited.add(neighbor)
                parent[neighbor] = current
                queue.append(neighbor)

    return None


# -----------------------------
# Depth First Search (DFS)
# -----------------------------
def dfs(graph, start, goal):
    visited = set()
    parent = {start: None}

    def dfs_visit(node):
        if node == goal:
            return True
        visited.add(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                parent[neighbor] = node
                if dfs_visit(neighbor):
                    return True
        return False

    found = dfs_visit(start)
    if found:
        return reconstruct_path(parent, goal)
    return None


# -----------------------------
# Path Reconstruction
# -----------------------------
def reconstruct_path(parent, goal):
    path = []
    current = goal
    while current is not None:
        path.append(current)
        current = parent[current]
    return path[::-1]


# -----------------------------
# Main Program
# -----------------------------
if __name__ == "__main__":

    # Graph (Adjacency List)
    graph = {
        'A': ['B', 'C'],
        'B': ['D', 'E'],
        'C': ['F'],
        'D': ['G'],
        'E': ['G'],
        'F': ['G'],
        'G': []
    }

    start_node = 'A'
    goal_node = 'G'

    bfs_path = bfs(graph, start_node, goal_node)
    dfs_path = dfs(graph, start_node, goal_node)

    print("BFS Path:", bfs_path)
    print("DFS Path:", dfs_path)
