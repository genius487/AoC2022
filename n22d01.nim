import strutils, algorithm, sequtils

var
  snacks = readFile("22day01.txt").strip().splitLines()
  bags: seq[int]
  totalCal = 0
  parts = [0,0]

for line in snacks:
  if line != "":
    totalCal.inc parseInt(line)
  else:
    bags.add totalCal
    totalCal = 0

sort(bags, Descending)

parts[0] = bags[0]
parts[1] = bags[0..2].foldr(a + b)

echo parts