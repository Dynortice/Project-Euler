function compute(k::Int, n::Int, modulo::Int = 1_000_000_007)::Int
    result, binomial, s = 0, 1, k
    power = powermod(2, n, modulo)
    power_inv = invmod(powermod(4, n ÷ k, modulo), modulo)
    for i ∈ 1 : k ÷ 2 + 1
        result = (result + binomial * power) % modulo
        binomial = binomial * s % modulo * (s - 1) % modulo * powermod(invmod(i, modulo), 2, modulo) % modulo
        s -= 2
        power = (power * power_inv) % modulo
    end
    return result
end
