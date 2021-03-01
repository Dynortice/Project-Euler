using IterTools: product
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(path::String, n::Int)::Int
    text = parse.(Int, split(replace(read(path, String), "\"" => ""), ","))
    keys = Dict(i => Int[] for i ∈ 1:n)
    letters = 97:122
    for i ∈ 1:n
        for j ∈ letters
            for k ∈ i:n:length(text)
                keys[i] = ∪(keys[i], j)
                if !(32 ≤ text[k] ⊻ j ≤ 122)
                    keys[i] = setdiff(keys[i], j)
                    break
                end
            end
        end
    end
    for key ∈ product(map(x -> x[2], sort(collect(keys)))...)
        decrypted_text = ""
        result = 0
        for (i, j) ∈ enumerate(text)
            xor = j ⊻ key[(i - 1) % n + 1]
            decrypted_text = string(decrypted_text, Char(xor))
            result += xor
        end
        if occursin(" the ", decrypted_text)
            return result
        end
    end
end

compute("problems/0059/p059_cipher.txt", 3)

@benchmark compute("problems/0059/p059_cipher.txt", 3)