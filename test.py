from math import sqrt

r = {}

for i in range(1, 600):
    for j in range(i, 600):
        k = i ** 2 + j ** 2
        if k == int(sqrt(k)) ** 2:
            p = sum([i, j, int(sqrt(k))])
            if p < 1000:
                if p in r:
                    r[p] += [(i, j)]
                else:
                    r[p] = [(i, j)]