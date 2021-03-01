using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(path::String)::String
    keylog = ∪(split(read(path, String), "\n")[1:end - 1])
    password = ""
    while length(keylog) ≠ 1
        candidates = ∪(i[1] for i ∈ keylog)
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
            if candidates[1] == key[1]
                if length(key) == 3 union!(keylog, [key[2:end]]) end
                setdiff!(keylog, [key])
            end
        end
    end
    return string(password, keylog[1])
end

compute("problems/0079/p079_keylog.txt")

@benchmark compute("problems/0079/p079_keylog.txt")