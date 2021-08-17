from euler.calculus import triangular_numbers


def compute(path: str) -> int:
    triangles = set(triangular_numbers(20))
    chars = {chr(ord('A') + i): i + 1 for i in range(26)}
    triangle_words = 0
    for word in open(path).read().replace('"', '').split(','):
        value = sum(chars[letter] for letter in word)
        if value in triangles:
            triangle_words += 1
    return triangle_words
