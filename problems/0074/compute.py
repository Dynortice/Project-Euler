from math import factorial, prod
from itertools import combinations_with_replacement
from collections import Counter


def compute(n: int, m: int):
    def get_next_term(k: int) -> int:
        return sum(factorials[digit] for digit in map(int, str(k)))

    def get_chain_len(k: int) -> int:
        if k in chains:
            return chains[k]
        term = k
        chain = [term]
        term = get_next_term(term)
        while term not in chain:
            chain.append(term)
            if term in chains:
                break
            term = get_next_term(term)
        index_term = chain.index(term)
        loop_len = chains[term] if term in chains else len(chain) - index_term
        for i, j in enumerate(chain):
            if i >= index_term:
                chains[j] = loop_len
            else:
                chains[j] = index_term - i + loop_len
        return chains[k]
    factorials = [factorial(i) for i in range(10)]
    chains = dict()
    result = 0
    for combination in combinations_with_replacement(range(9, -1, -1), n):
        combination = list(combination)
        for _ in range(combination.count(0) + 1):
            if get_chain_len(int(''.join(map(str, combination)))) == m:
                n_digits = len(combination)
                n_zeros = combination.count(0)
                counter = Counter(combination)
                result += (n_digits - n_zeros) * factorials[n_digits - 1] // prod([factorials[i]
                                                                                   for i in counter.values()])
            if 0 in combination:
                combination.remove(0)
                if len(combination) == 0:
                    break
    return result
