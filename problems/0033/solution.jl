using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    numerators_product = 1
    denominators_product = 1
    for i ∈ 1:9
        for j ∈ 1:i - 1
            for k ∈ 1:j - 1
                if (k * 10 + i) * j == (i * 10 + j) * k
                    numerators_product *= k
                    denominators_product *= j
                end
            end
        end
    end
    return(denominators_product ÷ gcd(numerators_product, denominators_product))
end

compute()

@benchmark compute()