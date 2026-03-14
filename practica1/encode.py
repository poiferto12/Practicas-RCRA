import sys

if len(sys.argv) != 3:
    print("Usage: python encode.py domXX.txt domXX.lp")
    sys.exit()

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file) as f:
    lines = [line.strip() for line in f if line.strip()]

N, M = map(int, lines[0].split())

grid = lines[1:N+1]
colholes = list(map(int, lines[N+1].split()))
rowholes = list(map(int, lines[N+2].split()))

with open(output_file, "w") as out:
    out.write(f"n({N}).\n")
    out.write(f"m({M}).\n")
    # cells and regions
    for x in range(N):
        for y in range(N):
            r = grid[x][y]
            out.write(f"cell({x},{y},{r}).\n")
    # holes per column
    for y in range(N):
        out.write(f"colholes({y},{colholes[y]}).\n")
    # holes per row
    for x in range(N):
        out.write(f"rowholes({x},{rowholes[x]}).\n")