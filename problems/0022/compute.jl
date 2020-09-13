function compute(file::AbstractString)::Int64
    chars = Dict(Char(Int('A') + i) => i + 1 for i in 0:25)
    return sum(i * chars[c] for (i, name) in enumerate(sort(split(replace(file, "\"" => ""), ","))) for c in name)
end
