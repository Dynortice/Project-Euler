include("euler/Julia/primes.jl")
using .Primes: get_primality

function compute(n::Int64)::Int64
    sieve = get_primality(n)
    prime_numbers = findall(sieve)
    max_sequence, max_sequence_sum = 0, 0
    for prime ∈ prime_numbers
        max_sequence_sum += prime
        if max_sequence_sum < n
            max_sequence += 1
        else
            break
        end
    end
    for i ∈ max_sequence:-1:0
        for j ∈ 1:length(prime_numbers) - i
            sum_sequence = sum(prime_numbers[j:i + j])
            if sum_sequence > n
                break
            elseif sieve[sum_sequence]
                return sum_sequence
            end
        end
    end
end