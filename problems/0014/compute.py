from euler.calculus import len_collatz_chain


def compute(n: int) -> int:
    result, max_chain, hashmap = 0, 0, {1: 1}
    for i in range(2, n):
        if len_collatz_chain(i, hashmap) > max_chain:
            result, max_chain = i, hashmap[i]
    return result
