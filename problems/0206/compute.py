from euler.big_int import BigInt


def compute() -> BigInt:
    def match(n):
        return all(n.str[i * 2] == str(i + 1) for i in range(9))

    number = BigInt(138902663)
    j = 3
    while not match(number * number):
        if j == 3:
            number -= 6
            j = 7
        else:
            number -= 4
            j = 3
    return number * 10
