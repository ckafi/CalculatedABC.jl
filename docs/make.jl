push!(LOAD_PATH,"../src/")

using Documenter
using ABCanalysis

makedocs(
    sitename = "ABCanalysis",
    authors = "Tobias Frilling",
    format = Documenter.HTML(),
    modules = [ABCanalysis]
)

deploydocs(
    repo = "github.com/ckafi/ABCanalysis"
)
