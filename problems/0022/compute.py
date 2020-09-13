def compute(file: str) -> int:
    chars = {chr(ord("A") + i): i + 1 for i in range(26)}
    return sum((i + 1) * chars[c] for (i, name) in enumerate(sorted(file.replace('"', '').split(','))) for c in name)
