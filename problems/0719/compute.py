def compute(n: int) -> int:
    def is_s_number(a: int, b: int) -> bool:
        if a > b:
            return False
        elif a == b:
            return True
        modulo = 10
        while modulo < b:
            quotient, remainder = b // modulo, b % modulo
            if remainder < a and is_s_number(a - remainder, quotient):
                return True
            modulo *= 10
        else:
            return False

    result = 0
    for i in range(2, n + 1):
        if is_s_number(i, i * i):
            result += i * i
    return result
