def filter_duplicates(data):
    # Write your code here
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)
    set_data = set()
    seen_data = set_data.add
    return [x for x in filter_duplicates if not (x in set_data or seen_data(x))]


print(filter_duplicates([7,9,1, 2, 3, 2, 4, 3, 5]))


    # seen = set()
    # seen_add = seen.add
    # return [x for x in seq if not (x in seen or seen_add(x))]