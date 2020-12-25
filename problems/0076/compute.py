def compute(n: int) -> int:
    combinations = [1] + [0] * n
    for i in range(1, n):
        for j in range(i, n + 1):
            combinations[j] += combinations[j - i]
    return combinations[-1]
