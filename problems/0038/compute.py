def compute() -> int:
    digits = set(map(str, range(1, 10)))
    for i in reversed(range(9234, 9488)):
        candidate = i * 100002
        if set(str(candidate)) == digits:
            return candidate
