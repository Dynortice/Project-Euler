from typing import Optional, Union
from math import ceil


def pad(s: str, n: int, right: bool = True) -> str:
    """Add `n` zeros before or after string

    Args:
        s: String
        n: Number of zeros to add
        right: Whether add 0 to right or left side

    Returns:
        Origin string with n leading or trailing zeros

    Examples:
        >>> print(pad('123', 2))
        12300
        >>> print(pad('123', 2, False))
        00123
    """
    return s + '0' * n if right else n * '0' + s


def align_strings(a: str, b: str, right: bool = True) -> (str, str):
    """Takes two strings and if these lengths not equal returns shorten string with leading or trailing zeros

    Args:
        a: First string
        b: Second string
        right: Whether add 0 to right or left side

    Returns:
        Tuple of 2 strings with equal lengths

    Examples:
        >>> print(align_strings("123", "123456"))
        ('123000', '123456')
        >>> print(align_strings("123456", "123", False))
        ('123456', '000123')
    """
    if len(a) > len(b):
        b = pad(b, len(a) - len(b), right)
    elif len(b) > len(a):
        a = pad(a, len(b) - len(a), right)
    return a, b


def mul_s(a: 'BigInt', b: 'BigInt') -> 'BigInt':
    if len(a) + len(b) < 19:
        return BigInt(str(int(a.str) * int(b.str)) if a.positive == b.positive else '-' + str(int(a.str) * int(b.str)))
    g, h = a.str[::-1], b.str[::-1]
    result = BigInt(0)
    for i in range(len(g)):
        carry = 0
        sub_result = '0' * i
        for j in range(len(h)):
            carry += int(g[i]) * int(h[j])
            sub_result += str(carry % 10)
            carry //= 10
        sub_result = sub_result[::-1]
        result += BigInt((str(carry) + sub_result).lstrip('0'))
    result.positive = a.positive == b.positive
    return result


class BigInt:
    """Class for big integers math

    Attributes:
        str: str
            Represents absolute value of number
        positive: bool
            Whether is number bigger or not than -1
    """

    def __init__(self, n: Union[int, str, 'BigInt']):
        """
        Params:
            n: Number represented as str, int or BigInt
        """
        if n:
            if isinstance(n, str):
                self.str = n if n[0] != '-' else n[1:]
                self.positive = n[0] != '-'
            elif isinstance(n, int):
                self.str = str(abs(n))
                self.positive = n >= 0
            elif isinstance(n, BigInt):
                self.str, self.positive = n.str, n.positive
            else:
                raise TypeError
        else:
            self.str = '0'
            self.positive = True

    def __len__(self) -> int:
        """Get number of digits"""
        return len(self.str)

    def __getitem__(self, item: int) -> str:
        """Get n-th digit"""
        return self.str[item]

    def __repr__(self) -> str:
        return str(self)

    def __str__(self) -> str:
        return self.str if self.positive else '-' + self.str

    def __neg__(self) -> 'BigInt':
        if self.positive:
            return BigInt('-' + self.str)
        else:
            return BigInt(self.str)

    def __abs__(self) -> 'BigInt':
        return BigInt(self.str)

    def __eq__(self, other: Union[int, str, 'BigInt']) -> bool:
        other = BigInt(other)
        return self.str == other.str and self.positive == other.positive

    def __lt__(self, other: Union[int, str, 'BigInt']) -> bool:
        other = BigInt(other)
        if self.positive == other.positive:
            if len(self) == len(other):
                if self == other:
                    return False
                else:
                    for i in range(len(self)):
                        if self[i] == other[i]:
                            continue
                        else:
                            return not (self[i] < other[i]) ^ self.positive
            else:
                return not (len(self) < len(other)) ^ self.positive
        else:
            return not self.positive

    def __gt__(self, other: Union[int, str, 'BigInt']) -> bool:
        return not self <= BigInt(other)

    def __le__(self, other: Union[int, str, 'BigInt']) -> bool:
        return self == other or self < other

    def __sub__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        other = BigInt(other)
        if self.positive == other.positive:
            if self == other:
                return BigInt(0)
            if self.positive:
                if self > other:
                    positive = True
                    x, y = self.str, other.str
                else:
                    positive = False
                    x, y = other.str, self.str
            else:
                if self > other:
                    positive = True
                    x, y = other.str, self.str
                else:
                    positive = False
                    x, y = self.str, other.str
            x, y = align_strings(x, y, right=False)
            result = ''
            carry = 0
            for i in range(ceil(len(x) / 18)):
                carry += int(x[-(i + 1) * 18:(-i * 18 if i > 0 else None)]) \
                         - int(y[-(i + 1) * 18:(-i * 18 if i > 0 else None)])
                if carry < 0:
                    result = '0' * (18 - len(str(10 ** 18 + carry))) + str(10 ** 18 + carry) + result
                    carry = -1
                else:
                    result = '0' * (18 - len(str(carry))) + str(carry) + result
                    carry = 0
            result = result.lstrip('0')
            if positive:
                return BigInt(result)
            else:
                return BigInt('-' + result)
        else:
            if self.positive:
                return self + -other
            else:
                return -(-self + other)

    def __add__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        other = BigInt(other)
        if self.positive == other.positive:
            x, y = align_strings(self.str, other.str, right=False)
            result = ''
            carry = 0
            for i in range(ceil(len(x) / 18)):
                carry += int(x[-(i + 1) * 18:(-i * 18 if i > 0 else None)]) \
                         + int(y[-(i + 1) * 18:(-i * 18 if i > 0 else None)])
                result = '0' * (18 - len(str(carry))) + str(carry)[-18:] + result
                carry //= 10 ** 18
            if carry != 0:
                result = str(carry) + result
            else:
                result = result.lstrip('0')
            if self.positive:
                return BigInt(result)
            else:
                return BigInt('-' + result)
        else:
            if self.positive:
                return self - -other
            else:
                return other - -self

    def __radd__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        return self + BigInt(other)

    def __mul__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        other = BigInt(other)
        if len(self) + len(other) < 19 or len(self) == 1 or len(other) == 1:
            return mul_s(self, other)
        n = len(self) if len(self) > len(other) else len(other)
        m = n // 2
        a, b, c, d = BigInt(self[:-m]), BigInt(self[-m:]), BigInt(other[:-m]), BigInt(other[-m:])
        ac, bd, ab_cd = a * c, b * d, (a + b) * (c + d)
        r = BigInt(pad(ac.str, 2 * m))
        s = BigInt(pad((ab_cd - ac - bd).str, m))
        res = r + s + bd
        res.positive = self.positive == other.positive
        return res

    def __rmul__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        return self * BigInt(other)

    def __floordiv__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        other = BigInt(other)
        if abs(self) < abs(other):
            result = BigInt(0)
        else:
            value = other.copy()
            multipliers = {1: value.copy()}
            i = 1
            while abs(self) > abs(value):
                value *= 2
                i *= 2
                multipliers[i] = value.copy()
            value = multipliers[1].copy()
            result = BigInt(1)
            for i in reversed(sorted(multipliers.keys())):
                if value + multipliers[i] <= abs(self):
                    result += i
                    value += multipliers[i]
        return result if self.positive == other.positive else -(result + 1)

    def __mod__(self, other: Union[int, str, 'BigInt']) -> 'BigInt':
        other = BigInt(other)
        if self.str == other.str:
            return BigInt(0)
        elif abs(self) > abs(other):
            return self - self // other * other
        elif self.positive == other.positive:
            return self.copy()
        else:
            return self + other

    def __pow__(self, other: Union[int, str, 'BigInt'], modulo: Optional[int] = None) -> 'BigInt':
        value = self.copy()
        other = BigInt(other)
        result = BigInt(1)
        if modulo:
            while other > 0:
                if other % 2 == 1:
                    result *= value
                    result %= modulo
                value *= value
                value %= modulo
                other //= 2
        else:
            while other > 0:
                if other % 2 == 1:
                    result *= value
                value *= value
                other //= 2
        return result

    def __rpow__(self, other: Union[int, str, 'BigInt'], modulo: Optional[int] = None) -> 'BigInt':
        return pow(BigInt(other), self, BigInt(other))

    def copy(self):
        return BigInt(('' if self.positive else '-') + self.str)
