using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(file::AbstractString)::Int64
    chars = Dict(Char(Int('A') + i) => i + 1 for i in 0:25)
    return sum(i * chars[c] for (i, name) in enumerate(sort(split(replace(file, "\"" => ""), ","))) for c in name)
end

file = read("problems/0022/p022_names.txt", String)

compute(file)

@benchmark compute(file)