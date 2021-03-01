function compute(n::Int)::Int
    limit_powers, limit_numbers = trunc(Int, log2(n)), trunc(Int, √n)
    power_counts = repeat([0], limit_powers)
    for i ∈ 2:limit_numbers
        power = trunc(Int, log(i, n))
        power_counts[power] += 1
        j = i * i
        while j ≤ limit_numbers
            power_counts[trunc(Int, log(j, n))] -= 1
            j *= i
        end
    end
    sieve = repeat([false], limit_powers * n)
    duplicate_counts = repeat([0], limit_powers)
    count = 0
    for i ∈ 1:limit_powers
        for j ∈ 2:n
            if sieve[i * j]
                count += 1
            else
                sieve[i * j] = true
            end
        end
        duplicate_counts[i] = count
    end
    return (n - 1) ^ 2 - sum(power_counts .* duplicate_counts)
end
