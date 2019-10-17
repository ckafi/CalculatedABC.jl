using Test
using ABCanalysis

using Random, Distributions
Random.seed!(123)

precision = 1.0e-15

include("test_curve.jl")
include("test_gini.jl")
