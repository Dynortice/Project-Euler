include("euler/euler.jl")
using .Game: dice_combinations
using .Math: fast_max

function compute(a::Tuple{Int, Int}, b::Tuple{Int, Int})::Float64
    limit = fast_max(a[1] * a[2], b[1] * b[2])
    looses = zeros(Int, limit)
    result = 0
    for i ∈ b[1]:b[1] * b[2] looses[i] = dice_combinations(i, b[1], b[2]) + looses[i - 1] end
    for i ∈ a[1]:a[1] * a[2] result += dice_combinations(i, a[1], a[2]) * looses[i - 1] end
    return round(result / a[2] ^ a[1] / b[2] ^ b[1], digits=7)
end
