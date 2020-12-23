function compute(n::Int64)::Int64
    perimeters = Dict{Int64, Int64}()
    for a ∈ 3:n÷3
        for b ∈ a:n÷2
            k = a * a + b * b
            if k == trunc(Int64, √k) ^ 2
                p = a + b + trunc(Int64, √k)
                if haskey(perimeters, p)
                    perimeters[p] += 1
                else
                    push!(perimeters, p => 1)
                end
            end
        end
    end
    return findmax(perimeters)[2]
end