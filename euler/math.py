from typing import Union
from euler.big_int import BigInt


def fast_max(a: Union[int, BigInt], b: Union[int, BigInt]) -> Union[int, BigInt]:
    """Get max between two numbers

    Args:
        a, b: Numbers

    Examples:
        >>> print(fast_max(100, 50))
        100
        >>> print(fast_max(BigInt(48), BigInt(49)))
        49
    """
    return a if a > b else b


def fast_min(a: Union[int, BigInt], b: Union[int, BigInt]) -> Union[int, BigInt]:
    """Get min between two numbers

    Args:
        a, b: Numbers

    Examples:
        >>> print(fast_min(100, 50))
        50
        >>> print(fast_min(BigInt(48), BigInt(49)))
        48
    """
    return a if a < b else b
