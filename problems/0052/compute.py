def compute(n: int) -> int:
    i = 1
    while True:
        for j in range(10 ** i, 10 ** (i + 1) // n):
            j_digits = sorted(str(j))
            for k in range(2, n + 1):
                k_digits = sorted(str(j * k))
                if j_digits != k_digits:
                    break
            else:
                return j
        i += 1
