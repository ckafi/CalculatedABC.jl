@testset "Gini coefficient" begin
    n = 20
    data = rand(n)
    curve = ABCanalysis.Curve(data)

    @test ABCanalysis.gini(data) ==  0.3008352645541903
end
