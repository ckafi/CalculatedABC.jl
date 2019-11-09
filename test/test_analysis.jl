Base.isapprox(x::Tuple, y::Tuple; kws...) = isapprox(collect(x), collect(y); kws...)

@testset "Analysis struct" begin
@testset "Uniformly distributed values" begin
    n = 20
    data = rand(Uniform(0,10), n)
    curve = CalculatedABC.ABCcurve(data)

    analysis1 = CalculatedABC.ABCanalysis(curve)
    @test isapprox(analysis1.pareto,      (0.4, 0.6192318028485929))
    @test isapprox(analysis1.break_even,  (0.5, 0.7210686469145638))
    @test isapprox(analysis1.demark_AB,   (0.4, 0.6192318028485929))
    @test isapprox(analysis1.submarginal, (0.6, 0.8125961014234772))

    analysis2 = CalculatedABC.ABCanalysis(data)
    @test isapprox(analysis2.pareto,      (0.4, 0.6192318028485929))
    @test isapprox(analysis2.break_even,  (0.5, 0.7210686469145638))
    @test isapprox(analysis2.demark_AB,   (0.4, 0.6192318028485929))
    @test isapprox(analysis2.submarginal, (0.6, 0.8125961014234772))
    @test analysis2.a_indices == [8, 10, 11, 20, 9, 17, 15, 5]
    @test analysis2.b_indices == [4, 18, 16, 12]
    @test analysis2.c_indices == [19, 7, 14, 6, 3, 1, 13, 2]
end

@testset "Exponentially distributed values" begin
    n = 20
    data = rand(Exponential(1), n)
    curve = CalculatedABC.ABCcurve(data)

    analysis1 = CalculatedABC.ABCanalysis(curve)
    @test isapprox(analysis1.pareto,      (0.35, 0.6503414525690906))
    @test isapprox(analysis1.break_even,  (0.35, 0.6503414525690906))
    @test isapprox(analysis1.demark_AB,   (0.35, 0.6503414525690906))
    @test isapprox(analysis1.submarginal, (0.5, 0.7704643555492489))

    analysis2 = CalculatedABC.ABCanalysis(data)
    @test isapprox(analysis2.pareto,      (0.35, 0.6503414525690906))
    @test isapprox(analysis2.break_even,  (0.35, 0.6503414525690906))
    @test isapprox(analysis2.demark_AB,   (0.35, 0.6503414525690906))
    @test isapprox(analysis2.submarginal, (0.5, 0.7704643555492489))
    @test analysis2.a_indices == [10, 1, 8, 18, 14, 11, 9]
    @test analysis2.b_indices == [17, 7, 16]
    @test analysis2.c_indices == [12, 3, 15, 5, 4, 6, 20, 13, 19, 2]
end

@testset "SwissInhabitants data" begin
    data = readdlm("swissinhabitants")[:,1]
    curve = CalculatedABC.ABCcurve(data)

    analysis1 = CalculatedABC.ABCanalysis(curve)
    @test isapprox(analysis1.pareto,      (0.25379834254143646, 0.7219586074342286))
    @test isapprox(analysis1.break_even,  (0.22168508287292818, 0.6913764432243525))
    @test isapprox(analysis1.demark_AB,   (0.22168508287292818, 0.6913764432243525))
    @test isapprox(analysis1.submarginal, (0.3715469613259669, 0.810278191608252))

    analysis2 = CalculatedABC.ABCanalysis(data)
    @test isapprox(analysis2.pareto,      (0.25379834254143646, 0.7219586074342286))
    @test isapprox(analysis2.break_even,  (0.22168508287292818, 0.6913764432243525))
    @test isapprox(analysis2.demark_AB,   (0.22168508287292818, 0.6913764432243525))
    @test isapprox(analysis2.submarginal, (0.3715469613259669, 0.810278191608252))
    # too many to test directly
    @test (analysis2.a_indices |> length) == 642
    @test (analysis2.b_indices |> length) == 434
    @test (analysis2.c_indices |> length) == 1820
    @test maximum(data[analysis2.a_indices]) <= minimum(data[analysis2.b_indices])
    @test maximum(data[analysis2.b_indices]) <= minimum(data[analysis2.c_indices])
end
end
