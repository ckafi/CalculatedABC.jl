@testset "Gini coefficient" begin
    n = 20
    data = rand(n)
    curve = ABCanalysis.Curve(data)

    answer = 0.3008352645541903
    @test ABCanalysis.gini(data) - answer < precision
    @test ABCanalysis.gini(curve) - answer < precision
end
