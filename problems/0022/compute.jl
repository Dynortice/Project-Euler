function compute(file::String)::Int64
    chars = Dict(Char(Int('A') + i) => i + 1 for i ∈ 0:25)
    return sum(i * chars[c] for (i, name) ∈ enumerate(sort(split(replace(file, "\"" => ""), ","))) for c ∈ name)
end
