from itertools import product


def compute(text: list, key_len: int) -> int:
    def is_letter(a, b):
        if 32 <= a ^ b <= 122:
            return True
        else:
            return False

    keys = {i: set() for i in range(key_len)}
    letters = range(97, 123)
    for i in range(key_len):
        for j in letters:
            for k in range(i, len(text), key_len):
                keys[i].add(j)
                if not is_letter(text[k], j):
                    keys[i].remove(j)
                    break

    for key in product(*list(keys.values())):
        decrypted_text = ''
        result = 0
        for i, n in enumerate(text):
            xor = n ^ key[i % key_len]
            decrypted_text += chr(xor)
            result += xor
        if ' the ' in decrypted_text:
            return result
