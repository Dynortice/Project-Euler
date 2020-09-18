from math import ceil, log10


def compute(n: int) -> int:
    result = 0
    for i in range(1, int(log10(n)) + 1):
        for j in range(10 ** ceil(i / 2 - 1), 10 ** ceil(i / 2)):
            palindrome = str(j) + str(j)[:i//2][::-1]
            if int(palindrome[0]) % 2 == 1:
                binary = bin(int(palindrome))[2:]
                if binary == binary[::-1]:
                    result += int(palindrome)
    return result
