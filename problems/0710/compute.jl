function compute(m::Int)::Int
    n = [4, 2, 1]
    power = i = 4
    result = 1
    while result != 0
        n = [mod(2n[1] - n[2] + n[3], m); n[1:2]]
        power = 2power % m
        result = power - n[2]
        i += 2
    end
    return i
end
