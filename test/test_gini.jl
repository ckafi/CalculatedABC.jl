@testset "Gini coefficient" begin
@testset "random data" begin
    n = 20
    data = rand(n)
    curve = ABCanalysis.ABCcurve(data)

    answer = 0.3008352645541903
    @test ABCanalysis.gini_coeff(data) - answer < precision
    @test ABCanalysis.gini_coeff(curve) - answer < precision
end

@testset "SwissInhabitants data" begin
    data = readdlm("swissinhabitants")[:,1]
    curve = ABCanalysis.ABCcurve(data) 

    answer = 0.6294073840902157
    @test ABCanalysis.gini_coeff(data) - answer < precision
    @test ABCanalysis.gini_coeff(curve) - answer < precision
end
end
