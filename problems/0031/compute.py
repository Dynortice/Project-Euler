def compute(coins: list[int], n: int) -> int:
    combinations = [1] + [0] * n
    for i in range(len(coins)):
        for j in range(coins[i], n + 1):
            combinations[j] += combinations[j - coins[i]]
    return combinations[-1]
