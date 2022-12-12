import std/strutils
import std/sugar
import std/strbasics
var input = open("input.txt")

let lowercaseZero = (int('a') - 1)
let uppercaseZero = (int('A') - 1)
var total = 0
for line in input.lines:
    let middle = len(line) div 2
    var first = line.dup(setSlice(0 .. (middle - 1)))
    var seccond = line.dup(setSlice(middle .. (len(line) - 1)))
    var dups = ""
    for c in first:
        if count(seccond, c) > 0:
            if count(dups, c) == 0:
                dups = dups & c
    for c in dups:
        if int(c) > lowercaseZero:
            total += (int(c) - lowercaseZero)
        else:
            total += (int(c) - uppercaseZero + 26)
echo "Total: $1" % [$total]
input.close()
input = open("input.txt")
total = 0
var i = 0
var group = ["", "", ""]
var badge = ' '
for line in input.lines:
    group[i] = line
    i += 1
    if i == 3:
        i = 0
        var found = false
        for c in group[0]:
            if (count(group[1], c) > 0) and (count(group[2], c) > 0) and not found:
                badge = c
                found = true
        if int(badge) > lowercaseZero:
            total += (int(badge) - lowercaseZero)
        else:
            total += (int(badge) - uppercaseZero + 26)
        badge = ' '
# Too low 2808
echo "task 2 total: $1" % [$total]