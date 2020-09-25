def compute(keylog: set) -> str:
    password = ''
    while True:
        if len(keylog) == 1:
            return password + list(keylog)[0]
        candidates = set(i[0] for i in keylog)
        for candidate in list(candidates):
            for key in keylog:
                if candidate in key[1:]:
                    candidates.remove(candidate)
                    break
        digit = list(candidates)[0]
        password += digit
        for key in list(keylog):
            if digit == key[0]:
                if len(key) == 3:
                    keylog.add(key[1:])
                keylog.remove(key)
