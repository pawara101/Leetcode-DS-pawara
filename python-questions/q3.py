import sys
import math
from contextlib import redirect_stdout


def solve(weight_0, weight_1, weight_2):
    # Write your code here
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)

    max_1 = find_heaviest_in_line(weight_0)
    max_2 = find_heaviest_in_line(weight_1)
    max_3 = find_heaviest_in_line(weight_2)

    heavy_list = [max_1, max_2, max_3]
    heaviest_pkg = max(heavy_list)
    
    return heavy_list.index(heaviest_pkg)



def find_heaviest_in_line(weight):
    if len(weight)==1:
        return weight[0]
    else:
        return max(weight)
    

# Ignore and do not change the code below
def main():
    # pylint: disable = C, W

    # game loop
    while True:
        weight_0 = int(input())
        weight_1 = int(input())
        weight_2 = int(input())
        with redirect_stdout(sys.stderr):
            action = solve(weight_0, weight_1, weight_2)
        print(action)


if __name__ == "__main__":
    main()
# Ignore and do not change the code above
