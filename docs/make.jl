push!(LOAD_PATH,"../src/")

using Documenter
using CalculatedABC

makedocs(
    sitename = "CalculatedABC.jl",
    authors = "Tobias Frilling",
    format = Documenter.HTML(),
    modules = [CalculatedABC],
    pages = [
        "Home" => "index.md",
        "ABC Curve" => "abccurve.md",
        "ABC Analysis" => "abcanalysis.md",
        "Gini Coefficient" => "gini.md"
    ]

)

deploydocs(
    repo = "github.com/ckafi/CalculatedABC.jl"
)
