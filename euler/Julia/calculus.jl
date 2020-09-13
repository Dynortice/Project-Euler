module calculus

    export sum_arithmetic_series, sum_geometric_series, fibonacci_number, fibonacci_index, len_collatz_chain

    sum_arithmetic_series(a::Real, d::Real, n::Integer)::Float64 = n * (2 * a + d * (n - 1)) / 2

    sum_geometric_series(a::Real, r::Real, n::Integer)::Float64 = a * (r ^ n - 1) / (r - 1)

    fibonacci_number(n::Integer)::Integer = trunc(Int, (((1 + √5) / 2) ^ n - ((1 - √5) / 2) ^ n) / √5)

    fibonacci_index(n::Integer)::Integer = trunc(Int, log((1 + √5) / 2, n * √5 + 0.5))

    function len_collatz_chain(n::Integer, hashmap::Dict)::Integer
        if !haskey(hashmap, n)
            hashmap[n] = n % 2 == 0 ? 1 + len_collatz_chain(n ÷ 2, hashmap) : 2 + len_collatz_chain((3 * n + 1) ÷ 2, hashmap)
        end
        return hashmap[n]
    end
end
