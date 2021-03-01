using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    months = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    day = 2
    result = 0
    for year ∈ 1901:2000
        months[2] = 28 + (year % 4 == 0 && (year % 100 ≠ 0 || year % 400 == 0))
        for month ∈ 1:12
            day += months[month] % 7
            if day % 7 == 0 result += 1 end
        end
    end
    return result
end

compute()

@benchmark compute()