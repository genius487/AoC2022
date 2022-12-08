import strutils, sequtils, sugar

var
  jungle = readFile("22day08.txt").strip.splitLines.mapIt(it.toSeq.mapIt(parseInt($it)))
  parts = [0,0]

proc analyzeTrees(tree: int, treesUp: seq[int], treesDown: seq[int], treesLeft: seq[int], treesRight: seq[int]): int =
  var 
    dist = [0,0,0,0]
    scenicScore: int

  for d, direction in [treesUp, treesDown, treesLeft, treesRight]:
    for trunk in direction:
      if trunk < tree:
        inc dist[d]
      elif trunk >= tree:
        inc dist[d]
        break

    if tree > direction.max:
      result = 1

  parts[0].inc(result)

  scenicScore = foldl(dist, a*b)
  if scenicScore > parts[1]:
    parts[1] = scenicScore


for row in 0..jungle.high:
  for col in 0..jungle[0].high:
    if row in [0, jungle.high] or col in [0, jungle[0].high]:
      inc parts[0]
    else:
      discard analyzeTrees(jungle[row][col],
                           collect(for x in countdown(row-1, 0): jungle[x][col]),
                           collect(for x in row+1..jungle.high: jungle[x][col]),
                           collect(for y in countdown(col-1, 0): jungle[row][y]),
                           jungle[row][col+1..jungle[0].high]
                          )
 

echo parts
