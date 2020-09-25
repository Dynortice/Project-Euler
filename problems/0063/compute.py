from euler.big_int import BigInt


def compute() -> int:
    result = 0
    i = 1
    while True:
        j = 1
        number, n = BigInt(str(i)), BigInt(str(i))
        if len(number) != j:
            break
        else:
            result += 1
        while True:
            j += 1
            number *= n
            if len(number) == j:
                result += 1
            else:
                break
        i += 1
    return result
