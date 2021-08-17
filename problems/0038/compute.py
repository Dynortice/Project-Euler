def compute() -> int:
    digits = set(map(str, range(1, 10)))
    for i in reversed(range(9_234, 9_488)):
        candidate = i * 100_002
        if set(str(candidate)) == digits:
            return candidate
