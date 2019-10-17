using Test
using ABCanalysis

using Random, Distributions
Random.seed!(123)

accuracy = 1.0e-15

include("test_curve.jl")
include("test_gini.jl")
