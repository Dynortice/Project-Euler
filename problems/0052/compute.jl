function compute(n::Int64)::Int64
    i = 1
    while true
        for j ∈ 10 ^ i:10 ^ (i + 1) ÷ n - 1
            j_digits = sort(collect(string(j)))
            is_permuted = true
            for k ∈ 2:n
                k_digits = sort(collect(string(j * k)))
                if j_digits != k_digits
                    is_permuted = false
                    break
                end
            end
            if is_permuted
                return j
            end
        end
    i += 1
    end
end