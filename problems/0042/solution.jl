using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(words::Array{SubString{String},1})::Int64
    triangles = [1]

    function add_triangle()
        n = length(triangles)
        append!(triangles, n * (n + 1) ÷ 2)
    end

    chars = Dict(Char(Int('A') + i) => i + 1 for i ∈ 0:25)
    triangle_words = 0

    for word ∈ words
        value = sum(chars[letter] for letter ∈ word)
        while value > maximum(triangles)
            add_triangle()
        end
        if value ∈ triangles
            triangle_words += 1
        end
    end
    return triangle_words
end

file = split(replace(read("problems/0042/p042_words.txt", String), "\"" => ""), ",")

compute(file)

@benchmark compute(file)