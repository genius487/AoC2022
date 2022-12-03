import strutils, tables

var
  matches = readFile("22day02.txt").strip().splitLines()
  parts = [0,0]
  outcomesP1 = initTable[string, int]()
  outcomesP2 = initTable[string, int]()

for m, opp in "ABCA":
  for n, me in "XYZX":
    if m == n:
      outcomesP1[opp & " " & me] = n mod 3 + 1 + 3
      outcomesP2[opp & " " & "Y"] = n mod 3 + 1 + 3
    elif n == m + 1:
      outcomesP1[opp & " " & me] = n mod 3 + 1 + 6
      outcomesP2[opp & " " & "Z"] = n mod 3 + 1 + 6
    elif n == m - 1:
      outcomesP1[opp & " " & me] = n mod 3 + 1
      outcomesP2[opp & " " & "X"] = n mod 3 + 1

for line in matches:
  parts[0].inc outcomesP1[line]
  parts[1].inc outcomesP2[line]

echo parts