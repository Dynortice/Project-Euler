using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute()::Int64 = 28433 * powermod(2, 7830457, 10 ^ 10) % 10 ^ 10 + 1

compute()

@benchmark compute()