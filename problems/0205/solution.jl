using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(a::Tuple{Int64, Int64}, b::Tuple{Int64, Int64})::Float64
    get_combinations(p::Int64, n::Int64, s::Int64)::Int64 = sum([(-1) ^ k * binomial(n, k) * binomial(p - 1 - s * k, n - 1) for k ∈ 0:(p - n) ÷ s])
    limit = maximum([prod(a), prod(b)])
    looses = zeros(Int64, limit)
    result = 0
    for i ∈ b[1]:prod(b)
        looses[i] = get_combinations(i, b...) + looses[i - 1]
    end
    for i ∈ a[1]:prod(a)
        result += get_combinations(i, a...) * looses[i - 1]
    end
    return round(result / a[2] ^ a[1] / b[2] ^ b[1], digits=7)
end

compute((9, 4), (6, 6))

@benchmark compute((9, 4), (6, 6))