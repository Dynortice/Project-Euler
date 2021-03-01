function compute(n::Int)::Int
    sieve = zeros(Int, n)
    for i ∈ 2:n
        sieve[i] += i - 1 - i ÷ 2 - i ÷ 3
        j = 2i
        sieve[j:i:n] -= sieve[i]
    end
    return sum(sieve)
end
