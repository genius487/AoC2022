import strutils, tables, strscans, sequtils, algorithm

var
  terminal = readFile("22day07.txt").strip.splitLines
  parts = [0,0]
  directorySizes = initTable[string, int]()
  usedSpace, spaceToFreeUp: int

proc dirSizeCalc(crsr: int = 0): (int, int) =
  var
    cursor = crsr
    files = initTable[string, int]()
    fileSize, size, place: int
    fileName: string

  while cursor <= terminal.high:
    if "$ cd" in terminal[cursor]:
      if ".." in terminal[cursor]:
        fileSize = foldl(files.values.toSeq, a + b)
        if fileSize <= 100000:
          parts[0].inc fileSize
        
        return (fileSize, cursor)
      else: 
        (size, place) = dirSizeCalc(cursor+2)
        files[terminal[cursor][5..^1]] = size
        directorySizes[terminal[cursor][5..^1]] = size

        cursor = place

    elif scanf(terminal[cursor], "$i $+", fileSize, fileName):
      files[fileName] = fileSize

    inc cursor

  return (foldl(files.values.toSeq, a + b), cursor)

usedSpace = dirSizeCalc()[0]
spaceToFreeUp = 30000000 - (70000000 - usedSpace)

for val in directorySizes.values.toSeq.sorted:
  if val >= spaceToFreeUp:
    parts[1] = val
    break

echo parts
