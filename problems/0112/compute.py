def compute(n: float) -> int:
    def is_bouncy(x: int) -> bool:
        digits = str(x)
        sorted_digits = ''.join(sorted(digits))
        if digits == sorted_digits or digits == sorted_digits[::-1]:
            return False
        else:
            return True
    bouncy = 0
    i = 1
    while True:
        bouncy += is_bouncy(i)
        if bouncy / i >= n:
            return i
        i += 1
