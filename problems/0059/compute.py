from itertools import product


def compute(path: str, n: int) -> int:
    text = list(map(int, open(path).read().split(',')))
    keys = {i: set() for i in range(n)}
    letters = range(97, 123)
    for i in range(n):
        for j in letters:
            for k in range(i, len(text), n):
                keys[i].add(j)
                if not 32 <= text[k] ^ j <= 122:
                    keys[i].remove(j)
                    break
    for key in product(*list(keys.values())):
        decrypted_text = ''
        result = 0
        for i, j in enumerate(text):
            xor = j ^ key[i % n]
            decrypted_text += chr(xor)
            result += xor
        if ' the ' in decrypted_text:
            return result
