function compute(modulo::Int64)::Int64
    get_next_n(n::Array{Int64,1})::Int64 = 2n[1] - n[2] + n[3]
    n = [4, 2, 1]
    power = 4
    i = 4
    result = 1
    while result != 0
        n = [mod(get_next_n(n), modulo); n[1:2]]
        power = power * 2 % modulo
        result = power - n[2]
        i += 2
    end
    return i
end
