import sys
import math
from contextlib import redirect_stdout


def compute_closest_to_zero(ts):
    # Write your code here
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)

   if len(ts) == 1:
    return ts[0]
   elif not ts:
       return 0
   else:
        abs_val = [abs(number) for number in ts]

        min_abs_val = min(abs_val)
        min_abs_val_index = abs_val.index(min_abs_val)


        min_indices = []
        ## Check for duplicates
        for i in range(len(ts)):
            if abs_val[i] == abs_val[min_abs_val_index]:
                min_indices.append(i)

        ## Check for duplicates

        if len(min_indices) == 1:
            return ts[min_abs_val_index]
        
        else:
            return abs(ts[min_abs_val_index])



# Ignore and do not change the code below
def main():
    # pylint: disable = C, W
    n = int(input())
    ts = [int(i) for i in input().split()]

    with redirect_stdout(sys.stderr):
        solution = compute_closest_to_zero(ts)
    print(solution)


if __name__ == "__main__":
    main()
# Ignore and do not change the code above
