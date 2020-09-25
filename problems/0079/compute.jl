function compute(keylog::Array{SubString{String},1})#::String
    password = ""
    while true
        if length(keylog) ≡ 1
            return string(password, keylog[1])
        end
        candidates = ∪(i[1] for i in keylog)
        for candidate ∈ collect(candidates)
            for key ∈ keylog
                if candidate ∈ key[2:end]
                    setdiff!(candidates, candidate)
                    break
                end
            end
        end
        password = string(password, candidates[1])
        for key ∈ collect(keylog)
            if candidates[1] ≡ key[1]
                if length(key) ≡ 3
                    union!(keylog, [key[2:end]])
                end
                setdiff!(keylog, [key])
            end
        end
    end
end