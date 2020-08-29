module calculus
    sum_arithmetic_series(a::Real, d::Real, n::Integer)::Float64 = n * (2 * a + d * (n - 1)) / 2
end