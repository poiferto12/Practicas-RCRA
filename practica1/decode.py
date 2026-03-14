import clingo
import sys

if len(sys.argv)<4:
    print("Usage: python decode.py stitches.lp dom.lp sol.txt")
    sys.exit()

input_files = sys.argv[1:-1]
output_file = sys.argv[-1]

ctl = clingo.Control()

# Load ASP files
for file in input_files:
    ctl.load(file)

ctl.ground([("base", [])])

N = 0
stitches = []
nummodels = 0

# Solving
with ctl.solve(yield_=True) as handle:
    for model in handle:
        if nummodels > 0:
            print("Warning: more than 1 model")
            break
        for atom in model.symbols(atoms=True):
            if atom.name == "n":
                N = atom.arguments[0].number
            elif atom.name == "stitch":
                x = atom.arguments[0].number
                y = atom.arguments[1].number
                x1 = atom.arguments[2].number
                y1 = atom.arguments[3].number
                stitches.append((x, y, x1, y1))
        nummodels = 1
if nummodels == 0:
    print("UNSATISFIABLE")
    sys.exit()

# create grid
grid = [[" " for _ in range(N)] for _ in range(N)]

# draw stitches
for (x, y, x1, y1) in stitches:
    if x == x1:  # horizontal
        if y < y1:
            grid[x][y] = ">"
            grid[x][y1] = "<"
        else:
            grid[x][y] = "<"
            grid[x][y1] = ">"
    if y == y1:  # vertical
        if x < x1:
            grid[x][y] = "v"
            grid[x1][y] = "^"
        else:
            grid[x][y] = "^"
            grid[x1][y] = "v"

# write solution file
with open(output_file, "w") as f:
    for row in grid:
        line = "".join(row)
        print(line)
        f.write(line + "\n")