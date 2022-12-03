import strutils, sequtils, sets

var
  rucksacks = readFile("22day03.txt").strip().splitLines()
  parts = [0,0]
  letters = {'a'..'z'}.toSeq & {'A'..'Z'}.toSeq

for l, line in rucksacks:
  parts[0].inc letters.find(
    (foldl(line.toSeq.distribute(2).mapIt(it.toHashSet), a * b).toSeq[0])
    ) + 1

  if (l+1) mod 3 == 0:
    parts[1].inc letters.find(
    (foldl(rucksacks[l-2..l].mapIt(it.toHashSet), a * b).toSeq[0])
    ) + 1


echo parts