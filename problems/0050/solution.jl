include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    sieve = primes.get_primality(n)
    prime_numbers = findall(sieve)
    max_sequence, max_sequence_sum = 0, 0
    for prime in prime_numbers
        max_sequence_sum += prime
        if max_sequence_sum < n
            max_sequence += 1
        else
            break
        end
    end
    for i in max_sequence:-1:0
        for j in 1:length(prime_numbers) - i
            sum_sequence = sum(prime_numbers[j:i + j])
            if sum_sequence > n
                break
            elseif sieve[sum_sequence]
                return sum_sequence
            end
        end
    end
end

compute(100)

compute(1000)

compute(1000000)

@benchmark compute(1000000)