def compute() -> int:
    modulo = 4503599627370517
    min_value = max_value = result = 1504170715041707
    while True:
        candidate = (min_value + max_value) % modulo
        if candidate > max_value:
            max_value = candidate
        elif candidate < min_value:
            min_value = candidate
            result += candidate
            if candidate == 1:
                break
    return result
