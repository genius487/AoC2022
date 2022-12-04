import strutils, strscans, sequtils

var
  ids = readFile("22day04.txt").strip().splitLines()
  parts = [0,0]
  i1, i2, i3, i4: int

for line in ids:
  if scanf(line, "$i-$i,$i-$i", i1, i2, i3, i4):
    if (i1 >= i3 and i2 <= i4) or (i3 >= i1 and i4 <= i2):
      parts[0].inc

    if i1 in toSeq(i3..i4) or i2 in toSeq(i3..i4) or i3 in toSeq(i1..i2) or i4 in toSeq(i1..i2):
      parts[1].inc


echo parts