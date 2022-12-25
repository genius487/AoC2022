import strutils, strscans, sequtils, algorithm

var
  notes = readFile("22day11.txt").strip.splitLines
  parts = [0,0]
  items: string
  divisor: int
  monkeys: seq[seq[int]]
  supermodulo = 1

proc doOperation(stuff: seq[int], divBy: int, op: char, var2: string): seq[int] =
  if var2 == "old":
    if op == '*': result = stuff.mapIt((it * it) div divBy)
    else: result = stuff.mapIt((it + it) div divBy)
  else:
    if op == '*': result = stuff.mapIt((it * parseInt(var2)) div divBy)
    else: result = stuff.mapIt((it + parseInt(var2)) div divBy)

proc playRounds(hands: seq[seq[int]], numRounds: int, worryModifier: int): seq[int] =
  var
    monkeyHands = hands
    monkeyActivity = newSeq[int](monkeyHands.len)
    monkeyNum, divisor, monkeyTrue, monkeyFalse: int
    items, var2: string
    op: char

  for round in 1..numRounds:
    for line in notes:
      if line.scanf("Monkey $i", monkeyNum): discard
      elif line.scanf("  Operation: new = old $c $+", op, var2):
        monkeyHands[monkeyNum] = doOperation(monkeyHands[monkeyNum], worryModifier, op, var2)
      elif line.scanf("  Test: divisible by $i", divisor): discard
      elif line.scanf("    If true: throw to monkey $i", monkeyTrue): discard
      elif line.scanf("    If false: throw to monkey $i", monkeyFalse): 
      
        for itm in monkeyHands[monkeyNum]:
          inc monkeyActivity[monkeyNum]
          if itm mod divisor == 0:
            monkeyHands[monkeyTrue].add itm mod supermodulo
          else:
            monkeyHands[monkeyFalse].add itm mod supermodulo

        monkeyHands[monkeyNum] = @[]

  return monkeyActivity


for line in notes:
  if scanf(line, "  Starting items: $+", items):
    monkeys.add items.split(", ").mapIt(it.parseInt)
  elif scanf(line, "  Test: divisible by $i", divisor):
    supermodulo *= divisor

parts[0] = playRounds(monkeys, 20, 3).sorted[^2..^1].foldl(a*b)
parts[1] = playRounds(monkeys, 10_000, 1).sorted[^2..^1].foldl(a*b)


echo parts