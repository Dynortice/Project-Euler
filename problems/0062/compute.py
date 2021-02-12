def compute(n: int) -> int:
    cubes = dict()
    permutations = dict()
    for i in range(10 ** n):
        permutation = ''.join(sorted(str(i ** 3)))
        if permutation in cubes:
            permutations[permutation] += 1
            if permutations[permutation] == n:
                return cubes[permutation]
        else:
            cubes[permutation] = i
            permutations[permutation] = 1
