using IterTools: product

function compute(k::Int)::Int
    digits = collect(join(1:k))
    possible_numbers = Dict(4 => [[1, 1]], 5 => [[1, 2]], 6 => [[1, 2]], 7 => [[1, 3], [2, 3]],
                            8 => [[1, 3], [2, 3]], 9 => [[1, 4], [2, 3]])
    products = []
    for (i, j) ∈ possible_numbers[k]
        for n ∈ product(fill(digits, i)...)
            if length(∪(n)) == i
                for m ∈ product(fill(setdiff(digits, n), j)...)
                    if length(∪(m)) == j
                        candidate = parse(Int, join(n)) * parse(Int, join(m))
                        if sort(vcat(collect(n), collect(m), collect(string(candidate)))) == digits
                            append!(products, candidate)
                        end
                    end
                end
            end
        end
    end
    return sum(∪(products))
end
