import math


def pad(a: str, n: int, right: bool = True) -> str:
    """
    Add 0 before or after string
    :param a: string
    :param n: count 0
    :param right: after (true) or before (false)
    :return: string eg "000123" when pad("123", 3, False)
    """
    return a + '0' * n if right else n * '0' + a


def zero_pad(a: str, b: str, right: bool = True) -> [str, str]:
    """
    Takes two string-like numbers and if these lengths not equal - return less number with 0 before or after
    :param a: string-like integer
    :param b: string-like integer
    :param right: after (true) or before (false)
    :return: list contains two string-like numbers
    """
    if len(a) > len(b):
        b = pad(b, len(a) - len(b), right)
    elif len(b) > len(a):
        a = pad(a, len(b) - len(a), right)
    return [a, b]


class BigInt:
    def __init__(self, n: str):
        if n == '':
            self.str = '0'
            self.positive = True
        else:
            self.str = n if n[0] != '-' else n[1:]
            self.positive = n[0] != '-'

    def __len__(self) -> int:
        return len(self.str)

    def __getitem__(self, item: int) -> str:
        return self.str[item]

    def __repr__(self) -> str:
        return repr(self.str if self.positive else '-' + self.str)

    def __neg__(self) -> 'BigInt':
        if self.positive:
            return BigInt('-' + self.str)
        else:
            return BigInt(self.str[1:])

    def __isub__(self, other: 'BigInt'):
        result = self - other
        self.str, self.positive = result.str, result.positive
        return self

    def __iadd__(self, other: 'BigInt'):
        result = self + other
        self.str, self.positive = result.str, result.positive
        return self

    def __imul__(self, other: 'BigInt'):
        result = self * other
        self.str, self.positive = result.str, result.positive
        return self

    def __eq__(self, other: 'BigInt') -> bool:
        return self.str == other.str and self.positive == other.positive

    def __lt__(self, other: 'BigInt') -> bool:
        if self.positive == other.positive:
            if len(self) == len(other):
                if self == other:
                    return False
                else:
                    for i in range(len(self)):
                        if self[i] == other[i]:
                            continue
                        else:
                            return self[i] < other[i] and self.positive
            else:
                return not (len(self) < len(other)) ^ self.positive
        else:
            return not self.positive

    def __le__(self, other: 'BigInt') -> bool:
        return self == other or self < other

    def __sub__(self, other) -> 'BigInt':
        if isinstance(other, BigInt):
            if self.positive != other.positive:
                if self.positive:
                    return self + -other
                else:
                    return -(-self + other)
            else:
                if self == other:
                    return BigInt('0')
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
                x, y = zero_pad(x, y, right=False)
                result = ''
                carry = 0
                for i in range(math.ceil(len(x) / 18)):
                    carry += int(x[-(i + 1) * 18:(-i * 18 if i > 0 else None)]) - int(y[-(i + 1) * 18:(-i * 18 if i > 0 else None)])
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
        elif isinstance(other, int):
            return self - BigInt(str(other))

    def __add__(self, other) -> 'BigInt':
        if isinstance(other, BigInt):
            if self.positive == other.positive:
                x, y = zero_pad(self.str, other.str, right=False)
                result = ''
                carry = 0
                for i in range(math.ceil(len(x) / 18)):
                    carry += int(x[-(i + 1) * 18:(-i * 18 if i > 0 else None)]) + int(y[-(i + 1) * 18:(-i * 18 if i > 0 else None)])
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
        elif isinstance(other, int):
            return self + BigInt(str(other))

    def __mul__(self, other) -> 'BigInt':
        if isinstance(other, BigInt):
            def mul(e: 'BigInt', f: 'BigInt') -> 'BigInt':
                if max(len(e), len(f)) < 10:
                    return BigInt(str(int(e.str) * int(f.str)) if e.positive == f.positive else '-' + str(
                        int(e.str) * int(f.str)))
                g, h = e.str[::-1], f.str[::-1]
                result = BigInt('0')
                for i in range(len(g)):
                    carry = 0
                    sub_result = '0' * i
                    for j in range(len(h)):
                        carry += int(g[i]) * int(h[j])
                        sub_result += str(carry % 10)
                        carry //= 10
                    sub_result = sub_result[::-1]
                    result += BigInt((str(carry) + sub_result).lstrip('0'))
                result.positive = e.positive == f.positive
                return result

            if max(len(self), len(other)) < 10 or min(len(self), len(other)) == 1:
                return mul(self, other)
            n = max(len(self), len(other))
            m = n // 2
            a, b, c, d = BigInt(self[:-m]), BigInt(self[-m:]), BigInt(other[:-m]), BigInt(other[-m:])
            ac, bd, ab_cd = a * c, b * d, (a + b) * (c + d)
            r = BigInt(pad(ac.str, 2 * m))
            s = BigInt(pad((ab_cd - ac - bd).str, m))
            res = r + s + bd
            res.positive = self.positive == other.positive
            return res
        elif isinstance(other, int):
            return self * BigInt(str(other))

    def __pow__(self, power: int, modulo=None) -> 'BigInt':
        value = self.copy()
        result = BigInt("1")
        while power > 0:
            if power % 2 == 1:
                result *= value
            value *= value
            power //= 2
        return result

    def copy(self):
        return BigInt(('' if self.positive else '-') + self.str)
