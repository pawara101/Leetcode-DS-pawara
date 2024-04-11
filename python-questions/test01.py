from json import dumps, loads
from typing import List


def add_drama(text: str) -> str:
    '''

    Args:

        - text (str): An ASCII string, defining the text to be dramatized.

    Returns:

        The dramatized string.
    '''

    dramatized_text = text.replace(".","!")

    return dramatized_text

# Ignore and do not change the code below


def try_solution(dramatized_text: str):
    '''
    Try a solution

    Args:

        - str (str): The dramatized string.
    '''
    json = dramatized_text
    print("" + dumps(json, separators=(',', ':')))

def main():
    res = add_drama(
        loads(input())
    )
    try_solution(res)


if __name__ == "__main__":
    main()
# Ignore and do not change the code above
