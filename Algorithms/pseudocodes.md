# Pseudo-codes for Design and analysis of Algorithms

### BFS
```
BFS(G(V, E): graph, s - vertex in G)
  foreach u in V
    visited[u]  <- false

  q <- empty queue
  q.push(s)
  visited[s] <- true

  while q not empty
    v <- q.pop()
    foreach u adjacent to v
      if !visited[u]
        q.push(u)
        visited[u] <- true
```

### DFS
```
foreach u in V
  visited[u] <- false

DFS(G(V, E): graph, s - vertex in G)
  foreach u adjacent to s
    if (!visited[u])
      visited[u] <- true
      DFS(u)
```

### Topological Sorting (Kahn's algorithm)
```
TopologicalSorting(G(V, E): graph)
  forearch u in V
  	suc[u] <- 0

  foreach (u, v) in E
    suc[u] <- suc[u] + 1

  foreach u in V
    if (suc[u] = 0)
      q.push(u)

  while q is not empty
    s <- q.pop()
    foreach (u, s) in E
      suc[u] <- suc[u] - 1
      if (suc[u] == 0) q.push(u)
```

### Dijkstra's algorithm for shortest path
```
Dijkstra(G(V, E): graph, s - vertex in G)
  foreach u in V
    dist[u] = infinity

  dist[s] <- 0
  pq <- empty priority queue, min is on top
  pq.push(s, dist[s])

  while pq not empty
    v, d <- pq.pop()
    if (d > dist[v]):
      continue

    foreach u adjacent to v
      if dist[u] > dist[v] + weight(v, u)
        dist[u] = dist[v] + weight(v, u)
        pq.push(u, dist[u])

  return dist[]
```

### Union-find / Disjoint-set
```
# f[s] = u - node s is from the same tree as u,
#            if u = -1 -> s is root of the tree

# finds the root of the tree in which is s;
# with path compression - every node between
# s and the root is now directly connected to the root

find (s):
  if (f[s] != -1):
    # then s is not the root
    f[s] <- find(f[s])
  return f[s]

# important - v should be the root of its tree
union (u, v):
  f[u] = v
```

### Kruskal's algorithms for MST
```
kruskal(G(V, E): graph):
  tree <- {}
  f[s] <- -1 for each s in V
  E <- sort(E) # for minimum-spanning tree, the order is ascending

  for (each edge (u, v) in E):
    root_u <- find(u)
    root_v <- find(v)

    if (root_u != root_v):
      union(root_u, root_v)
      tree <- tree + edge(u, v)

  return tree
```

### Articulations points / Cut points / Critical vertexes
```
  # cut[s] = true, if s is an articulation point
  # in - a global variable

  dfs(s):
    preorder[s] <- in
    in <- in + 1
    lowest[s] <- preorder[s]
    children <- 0

    for each edge (s, v):
      if (used[v]):
        // (s, v) - back edge
        lowest[s] <- min (lowest[s], preorder[v])
      else:
        children <- children + 1
        used[v] <- true
        dfs(v)
        lowest[s] <- min (lowest[s], lowest[v])

        if (lowest[s] <= lowest[v]):
          cut[s] <- true

    if (s is a root):
      cut[s] <- (children > 1)

  articulationPoints(Graph(V, E)):
    used[s] <- false for each s in V
    cut[s] <- false for each s in V
    in <- 1

    v <- some node from V
    used[v] <- true
    dfs(v)
```
