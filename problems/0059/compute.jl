using IterTools: product

function compute(text::Array{Int64,1}, key_len::Int64)::Int64
    is_letter(a::Int64, b::Int64)::Bool = 32 ≤ a ⊻ b ≤ 122

    keys = Dict(i => Int64[] for i ∈ 1:key_len)
    letters = 97:122
    for i ∈ 1:key_len
        for j ∈ letters
            for k ∈ i:key_len:length(text)
                keys[i] = ∪(keys[i], j)
                if !is_letter(j, text[k])
                    keys[i] = setdiff(keys[i], j)
                    break
                end
            end
        end
    end
    for key ∈ product(map(x -> x[2], sort(collect(keys)))...)
        decrypted_text = ""
        result = 0
        for (i, n) ∈ enumerate(text)
            xor_ = n ⊻ key[(i - 1) % key_len + 1]
            decrypted_text = string(decrypted_text, Char(xor_))
            result += xor_
        end
        if occursin(" the ", decrypted_text)
            return result
        end
    end
end
