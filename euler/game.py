from math import comb


def dice_combinations(p: int, n: int, s: int) -> int:
    """Get number of combinations of totals `p` for `n` `s`-sided dices

    Args:
        p: Total sum of dices
        n: Number of dices
        s: Number of sides for each dice

    Examples:
        >>> print(dice_combinations(6, 6, 6))
        1
        >>> print(dice_combinations(16, 8, 4))
        3823

    """
    return int(sum([(-1) ** k * comb(n, k) * comb(p - 1 - s * k, n - 1) for k in range((p - n) // s + 1)]))
