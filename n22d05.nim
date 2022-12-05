import strutils, strscans

var
  input = readFile("22day05.txt")
  parts = ["",""]
  crates = input.split("\n\n")[0].splitLines
  procedure = input.split("\n\n")[1].splitLines
  towers: seq[seq[char]]
  column: seq[char]
  moves, crateFrom, crateTo: int


for col, stackNum in crates[^1]:
  if stackNum.isDigit:
    column = @[]
    for line in countdown(crates.high-1, 0):
      if crates[line][col].isAlphaAscii:
        column.add crates[line][col]
    towers.add column

proc craneOpps(part: char): string =
  var stacks = towers

  for line in procedure:
    if scanf(line, "move $i from $i to $i", moves, crateFrom, crateTo):
      if part == 'A':
        for m in 1..moves:
          stacks[crateTo-1].add stacks[crateFrom-1].pop
      elif part == 'B':
        for crate in stacks[crateFrom-1][^moves..^1]:
          stacks[crateTo-1].add crate
        stacks[crateFrom-1] = stacks[crateFrom-1][0 ..< ^moves]       
        
  for s in stacks:
    result.add s[^1]


parts[0] = craneOpps('A')
parts[1] = craneOpps('B')
    
echo parts