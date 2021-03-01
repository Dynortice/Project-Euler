compute(n::Int)::Int = Int(ceil((log(10) * (n - 1) + 0.5log(5)) / log(0.5(1 + √5))))
