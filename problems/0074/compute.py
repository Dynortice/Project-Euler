from math import factorial, prod
from itertools import combinations_with_replacement
from collections import Counter


def compute(n: int, m: int):
    factorials = [factorial(i) for i in range(10)]
    chains = dict()
    result = 0
    for combination in combinations_with_replacement(range(9, -1, -1), n):
        combination = list(combination)
        for _ in range(combination.count(0) + 1):
            number = int(''.join(map(str, combination)))
            if number not in chains:
                chain = [number]
                term = sum(factorials[digit] for digit in map(int, str(number)))
                while term not in chain:
                    chain.append(term)
                    if term in chains:
                        break
                    term = sum(factorials[digit] for digit in map(int, str(term)))
                index = chain.index(term)
                loop_len = chains[term] if term in chains else len(chain) - index
                for i, j in enumerate(chain):
                    if i >= index:
                        chains[j] = loop_len
                    else:
                        chains[j] = index - i + loop_len
            if chains[number] == m:
                digits = len(combination)
                result += (digits - combination.count(0)) * factorials[digits - 1] \
                    // prod([factorials[i] for i in Counter(combination).values()])
            if 0 in combination:
                combination.remove(0)
                if len(combination) == 0:
                    break
    return result
