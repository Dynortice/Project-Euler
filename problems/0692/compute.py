from euler.calculus import fibonacci_index, fibonacci_numbers


def compute(n: int):
    index = fibonacci_index(n)
    fibonacci = list(fibonacci_numbers(index, int))
    last_sum, new_sum = 0, 0
    result = sum(fibonacci[:5]) - 1
    for i in range(5, index + 1):
        last_sum, new_sum = new_sum, new_sum + last_sum + fibonacci[i - 3]
        result += new_sum + fibonacci[i]
    return result
