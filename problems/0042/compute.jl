include("euler/euler.jl")
using .Calculus: triangular_numbers

function compute(path::String)::Int
    triangles = triangular_numbers(20)
    chars = Dict(Char(Int('A') + i) => i + 1 for i ∈ 0:25)
    triangle_words = 0
    for word ∈ split(replace(read(path, String), "\"" => ""), ",")
        value = sum(chars[letter] for letter ∈ word)
        if value ∈ triangles triangle_words += 1 end
    end
    return triangle_words
end