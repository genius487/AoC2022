import strutils, sets

var
  buffer = readFile("22day06.txt").strip
  parts = [0,0]
  
proc findStart(packetLength: int): int =
  for b in 0..buffer.high-(packetLength-1):
    if buffer[b..b+(packetLength-1)].len == buffer[b..b+(packetLength-1)].toHashSet.len:
      return b+packetLength

parts[0] = findStart(4)
parts[1] = findStart(14)
    
echo parts