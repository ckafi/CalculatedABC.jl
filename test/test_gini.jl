@testset "Gini coefficient" begin
    n = 20
    data = rand(n)
    curve = ABCanalysis.ABCcurve(data)

    answer = 0.3008352645541903
    @test ABCanalysis.gini_coeff(data) - answer < precision
    @test ABCanalysis.gini_coeff(curve) - answer < precision
end
