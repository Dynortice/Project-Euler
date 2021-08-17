def compute(first: int, modulo: int) -> int:
    min_value = max_value = result = first
    candidate = 0
    while candidate != 1:
        candidate = (min_value + max_value) % modulo
        if candidate > max_value:
            max_value = candidate
        elif candidate < min_value:
            min_value = candidate
            result += candidate
    return result
