module calculus
    sum_arithmetic_series(a::Real, d::Real, n::Integer)::Float64 = n * (2 * a + d * (n - 1)) / 2

    fibonacci_number(n::Integer) = trunc(Int, (((1 + √5) / 2) ^ n - ((1 - √5) / 2) ^ n) / √5)

    fibonacci_index(n::Integer) = trunc(Int, log((1 + √5) / 2, n * √5 + 0.5))
end
