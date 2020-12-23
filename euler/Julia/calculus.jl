module Calculus

    include("big_int.jl")
    using .BigIntegers: BigInteger

    export sum_arithmetic_series, sum_geometric_series, fibonacci_number, fibonacci_index, len_collatz_chain

    sum_arithmetic_series(a::Real, d::Real, n::Int64)::Float64 = n * (2 * a + d * (n - 1)) / 2

    sum_geometric_series(a::Real, r::Real, n::Int64)::Float64 = a * (r ^ n - 1) / (r - 1)

    fibonacci_number(n::Int64)::Int64 = trunc(Int, (((1 + √5) / 2) ^ n - ((1 - √5) / 2) ^ n) / √5)

    fibonacci_index(n::Int64)::Int64 = trunc(Int, log((1 + √5) / 2, n * √5 + 0.5))

    function get_fibonacci(n::Int64)::Array{BigInteger, 1}
        f_prev, f_curr = BigInteger(0), BigInteger(1)
        result = [f_prev, f_curr]
        for i ∈ 2:n
            f_prev, f_curr = f_curr, f_prev + f_curr
            push!(result, f_curr)
        end
        return result
    end

    function len_collatz_chain(n::Int64, hashmap::Dict)::Int64
        if !haskey(hashmap, n)
            hashmap[n] = n % 2 == 0 ? 1 + len_collatz_chain(n ÷ 2, hashmap) : 2 + len_collatz_chain((3 * n + 1) ÷ 2, hashmap)
        end
        return hashmap[n]
    end

    get_triangle(n::Int64)::Int64 = n * (n + 1) ÷ 2

    get_pentagonal(n::Int64)::Int64 = n * (3n - 1) ÷ 2

    get_hexagonal(n::Int64)::Int64 = n * (2n - 1)

    is_triangle(n::Int64)::Bool = √(8n + 1) % 2 ≡ 1.0

    is_pentagonal(n::Int64)::Bool = √(24n + 1) % 6 ≡ 5.0

    is_hexagonal(n::Int64)::Bool = √(8n + 1) % 4 ≡ 3.0

    triangle_index(n::Int64)::Int64 = (√(8n + 1) + 1) ÷ 2

    pentagonal_index(n::Int64)::Int64 = (√(24n + 1) + 1) ÷ 6

    hexagonal_index(n::Int64)::Int64 = (√(8n + 1) + 1) ÷ 4

end
