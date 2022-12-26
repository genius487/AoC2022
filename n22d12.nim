import strutils, sets, heapqueue

var
  heightmap = readFile("22day12.txt").strip.splitLines
  parts = [0,0]
  start, bestSignalPos: seq[int]
  elevationAseq: seq[seq[int]]
  newShortest: int


type Node = object
  elevation: char
  stepsTaken: int
  till: seq[int]
  fram: seq[int]


proc findAdjacents(point: seq[int], iMax: int, jMax: int): seq[seq[int]] =
  var
    i = point[0]
    j = point[1]
    adjacentsRef: seq[seq[int]]

  if i != iMax: adjacentsRef.add(@[i+1,j])
  if i != 0: adjacentsRef.add(@[i-1,j])
  if j != jMax: adjacentsRef.add(@[i,j+1])
  if j != 0: adjacentsRef.add(@[i,j-1])

  return adjacentsRef

proc `<` (a, b: Node): bool =
  a.stepsTaken < b.stepsTaken

proc shortestPathAStar(currPos: seq[int], endPos: seq[int], maze: seq[string]): int =
  var
    currPos = currPos
    nodeData = Node(elevation: 'a', stepsTaken: 0, till: currPos, fram: currPos)
    currData: nodeData.type
    priority = initHeapQueue[Node]()
    visited = initHashSet[seq[int]]()

  priority.push(nodeData)

  while currPos != endPos:
    currData = priority[0]
    discard priority.pop

    if currPos notin visited:
      for nearby in findAdjacents(currPos, maze.high, maze[0].high):

        if nearby notin visited:
          nodeData.elevation = maze[nearby[0]][nearby[1]]
          nodeData.fram = currPos
          nodeData.till = nearby
          nodeData.stepsTaken = currData.stepsTaken + 1

          if nodeData.elevation != 'E':
            if nodeData.elevation.ord - currData.elevation.ord <= 1:
              priority.push(nodeData)
          elif currData.elevation == 'z':
            priority.push(nodeData)

      visited.incl(currPos)

    if priority.len == 0:
      return 99999
    else:
      currPos = priority[0].till

  return priority[0].stepsTaken


for row in 0..heightmap.high:
  for col in 0..heightmap[0].high:
    if heightmap[row][col] == 'S':
      start = @[row,col]
      elevationAseq.add start
    elif heightmap[row][col] == 'E':
      bestSignalPos = @[row,col]
    elif heightmap[row][col] == 'a':
      elevationAseq.add @[row,col]

parts[0] = shortestPathAStar(start, bestSignalPos, heightmap)
parts[1] = parts[0]

for i, a in elevationAseq:
  newShortest = shortestPathAStar(a, bestSignalPos, heightmap)
  if newShortest < parts[1]: 
    parts[1] = newShortest

echo parts