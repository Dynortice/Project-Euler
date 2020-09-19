def compute(file: str) -> int:
    triangles = {1}

    def add_triangle():
        n = len(triangles) + 1
        triangles.add(n * (n + 1) // 2)

    chars = {chr(ord("A") + i): i + 1 for i in range(26)}
    triangle_words = 0

    for word in file.replace('"', '').split(','):
        value = sum(chars[letter] for letter in word)
        while value > max(triangles):
            add_triangle()
        if value in triangles:
            triangle_words += 1

    return triangle_words
