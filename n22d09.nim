import strutils, strscans, sets

var
  motions = readFile("22day09.txt").strip.splitLines
  parts = [0,0]
  rope: seq[seq[int]]
  knotHistoryP1, knotHistoryP2: HashSet[seq[int]]
  direction: string
  steps: int

proc moveHead(head: var seq[int], direction: string): int =
  case direction
  of "R": head[0].inc(1)
  of "L": head[0].dec(1)
  of "U": head[1].inc(1)
  of "D": head[1].dec(1)
  else: discard

proc moveKnot(front, back: var seq[int]): seq[int] = 
  var relPos = @[front[0]-back[0], front[1]-back[1]]

  for r, pos in relPos:
    if abs(pos) == 2:
      back[r].inc(pos div abs(pos))

      if abs(relPos[1-r]) == 1:
        back[1-r].inc(relPos[1-r] div abs(relPos[1-r]))

  return back

for knot in 1..10:
  rope.add @[0,0]

knotHistoryP1 = toHashSet([rope[1]])
knotHistoryP2 = toHashSet([rope[^1]])

for line in motions:
  if scanf(line, "$w $i", direction, steps):
    for s in 1..steps:
      discard moveHead(rope[0], direction)
      for knot in 1..rope.high:
        rope[knot] = moveTail(rope[knot-1], rope[knot])
      knotHistoryP1.incl rope[1]
      knotHistoryP2.incl rope[^1]

parts[0] = knotHistoryP1.len
parts[1] = knotHistoryP2.len

echo parts