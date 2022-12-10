import strutils, strscans, sequtils

var
  input = readFile("22day10.txt").strip.splitLines
  parts = [0,0]
  register = @[1]
  val, midSprite: int
  screen: string
  posSprite: seq[int]
  
for j, job in input:
  register.add 0

  if job == "noop":
    discard
  elif scanf(job, "addx $i", val):
    register.add val

for c in countup(20, 220, 40):
  parts[0].inc foldl(register[0..c-1], a+b) * c

for posCRT, val in register:
  midSprite += val
  posSprite = @[midSprite-1, midSprite, midSprite+1]
  if posCRT mod 40 in posSprite: 
    screen.add "#"
  else:
    screen.add " "

for i in countup(0, 220, 40):
  echo screen[i..i+39]


echo parts