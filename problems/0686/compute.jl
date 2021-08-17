function compute(d::Int, n::Int)::Int
    function mod1(k::Float64)::Float64
        k %= 1
        return k < 0.5 ? k : k - 1
    end

    check(k::Float64)::Bool = (lower && lower_limit ≤ k < upper_limit) || (!lower && lower_limit ≥ k > upper_limit)

    limit = (log(d + 1) - log(d)) / log(10)
    lower_limit, upper_limit = log(d) / log(10) % 1, log(d + 1) / log(10) % 1
    lower = lower_limit < upper_limit
    error = log(2) / log(10)
    x = error % 1
    t, convergent, convergent_error = 0, 1, 1
    while abs(convergent_error) > limit
        x, integer = modf(1 / x)
        convergent, t = convergent * integer + t, convergent
        convergent_error = mod1(convergent * error)
    end
    x, integer = modf(1 / x)
    semi_convergent, semi_convergent_error = t, 1
    while abs(semi_convergent_error) > limit
        semi_convergent += convergent
        semi_convergent_error = mod1(semi_convergent * error)
    end
    differences = (convergent, semi_convergent, convergent + semi_convergent)
    if convergent_error > 0
        convergent_limit = convergent * ceil(lower_limit / convergent_error)
    else
        convergent_limit = semi_convergent * ceil(lower_limit / semi_convergent_error)
    end
    convergents = Vector{Float64}()
    while convergent < convergent_limit
        append!(convergents, convergent)
        convergent, t = integer * convergent + t, convergent
        x, integer = modf(1 / x)
    end
    convergents = convergents[2:end]
    for difference ∈ reverse(convergents)
        while convergent_limit > difference
            x = (convergent_limit - difference) * error % 1
            if check(x)
                convergent_limit -= difference
            else
                break
            end
        end
    end
    while true
        checked = false
        for difference ∈ differences
            if difference > convergent_limit
                continue
            end
            x = (convergent_limit - difference) * error % 1
            if check(x)
                checked = true
                convergent_limit -= difference
                break
            end
        end
        if !checked break end
    end
    while true
        for difference ∈ differences
            x = (convergent_limit + difference) * error % 1
            if check(x)
                n -= 1
                if n == 0
                    return trunc(Int, convergent_limit)
                end
                convergent_limit += difference
                break
            end
        end
    end
end