from euler.big_int import BigInt


def compute() -> BigInt:
    number = BigInt(138902663)
    j = 3
    while not all((number * number)[i * 2] == str(i + 1) for i in range(9)):
        if j == 3:
            number -= 6
            j = 7
        else:
            number -= 4
            j = 3
    return number * 10
