import sys
import math
from contextlib import redirect_stdout


def solve(width, height, nb_blocks, grid):
    # Write your code here
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)
    ## get unique values in grid
    if width == len(grid):

        return grid[0]
    elif width==1 and height==1:
        return grid[0,-1]
    ## get unique values in grid

    elif height==1 and width!=1:
        return grid[-1]
    
    else:
        return grid[0,-1]

print(solve(3,1,3,[1,0,2]))


"""
import sys
import math
from contextlib import redirect_stdout


def solve(width, height, nb_blocks, grid):
    # Write your code here
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)
    ## get unique values in grid
    if width == len(grid):

        return grid[0]
    elif width==1 and height==1:
        return grid[0,-1]
    ## get unique values in grid

    elif height==1 and width!=1:
        return grid[-1]
    
    else:
        return grid[0,-1]

# Ignore and do not change the code below
def main():
    # pylint: disable = C, W
    width, height, nb_blocks = [int(i) for i in input().split()]

    # game loop
    while True:
        grid = []
        for i in range(height):
            grid.append(input())
        with redirect_stdout(sys.stderr):
            moves = solve(width, height, nb_blocks, grid)
        print(moves)


if __name__ == "__main__":
    main()
# Ignore and do not change the code above


"""
