push!(LOAD_PATH,"../src/")

using Documenter
using CalculatedABC

makedocs(
    sitename = "CalculatedABC.jl",
    authors = "Tobias Frilling",
    format = Documenter.HTML(),
    modules = [CalculatedABC]
)

deploydocs(
    repo = "github.com/ckaCalculatedABCfi/CalculatedABC.jl"
)
