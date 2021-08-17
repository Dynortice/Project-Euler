from math import ceil, log, modf


def compute(digits: int, n: int) -> int:
    def mod(k: float) -> float:
        k %= 1
        return k if k < 0.5 else k - 1

    def check(k: float) -> bool:
        return (lower and lower_limit <= k < upper_limit) or (not lower and lower_limit >= k > upper_limit)

    limit = (log(digits + 1) - log(digits)) / log(10)
    lower_limit, upper_limit = log(digits) / log(10) % 1, log(digits + 1) / log(10) % 1
    lower = lower_limit < upper_limit
    error = log(2) / log(10)
    x = error % 1
    t, convergent, convergent_error = 0, 1, 1
    while abs(convergent_error) > limit:
        x, integer = modf(1 / x)
        convergent, t = convergent * integer + t, convergent
        convergent_error = mod(convergent * error)
    x, integer = modf(1 / x)
    semi_convergent, semi_convergent_error = t, 1
    while abs(semi_convergent_error) > limit:
        semi_convergent += convergent
        semi_convergent_error = mod(semi_convergent * error)
    differences = (convergent, semi_convergent, convergent + semi_convergent)
    if convergent_error > 0:
        convergent_limit = convergent * ceil(lower_limit / convergent_error)
    else:
        convergent_limit = semi_convergent * ceil(lower_limit / semi_convergent_error)
    convergents = list()
    while convergent < convergent_limit:
        convergents.append(convergent)
        convergent, t = integer * convergent + t, convergent
        x, integer = modf(1 / x)
    convergents = convergents[1:]
    for difference in reversed(convergents):
        while convergent_limit > difference:
            x = (convergent_limit - difference) * error % 1
            if check(x):
                convergent_limit -= difference
            else:
                break
    while True:
        for difference in differences:
            if difference > convergent_limit:
                continue
            x = (convergent_limit - difference) * error % 1
            if check(x):
                convergent_limit -= difference
                break
        else:
            break
    while True:
        for difference in differences:
            x = (convergent_limit + difference) * error % 1
            if check(x):
                n -= 1
                if n == 0:
                    return int(convergent_limit)
                convergent_limit += difference
                break
