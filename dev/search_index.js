var documenterSearchIndex = {"docs":
[{"location":"gini/#Gini-coefficient-1","page":"Gini Coefficient","title":"Gini coefficient","text":"","category":"section"},{"location":"gini/#","page":"Gini Coefficient","title":"Gini Coefficient","text":"The Gini coefficient is a single number aimed at measuring the degree of inequality in a distribution. It is usually defined mathematically based on the Lorenz curve. A Gini coefficient of zero expresses perfect equality, where all values are the same, whereas a coefficient of 1 expresses maximal inequality among values.","category":"page"},{"location":"gini/#","page":"Gini Coefficient","title":"Gini Coefficient","text":"gini_coeff(data::Vector{<:Real})\ngini_coeff(curve::ABCcurve)","category":"page"},{"location":"gini/#CalculatedABC.gini_coeff-Tuple{Array{#s1,1} where #s1<:Real}","page":"Gini Coefficient","title":"CalculatedABC.gini_coeff","text":"gini_coeff(data::Vector{<:Real})\n\nCalculates the Gini coefficient for the given data.\n\n\n\n\n\n","category":"method"},{"location":"gini/#CalculatedABC.gini_coeff-Tuple{ABCcurve}","page":"Gini Coefficient","title":"CalculatedABC.gini_coeff","text":"gini_coeff(curve::ABCcurve)\n\nCalculates the Gini coefficient for the given ABC curve.\n\n\n\n\n\n","category":"method"},{"location":"plotting/#Plotting-1","page":"Plotting","title":"Plotting","text":"","category":"section"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"For both ABCcurve and ABCanalysis there are recipes for Plots.jl visualisations. These understand the usual Plots.jl parameters like markershape etc.","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"The plot for ABCcurve shows the curve in comparison with ABC curves for uniformly distributed values (green) and identical values (magenta). These can be switches off with comparison=false.","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"curve = ABCcurve(data)\nplot(curve)","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"(Image: )","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"The plot for ABCanalysis extends the curve plot with line boundaries for the A, B and C sets (red lines) and markers for the Pareto point (green), Break Even point (red) and the Submarginal point (blue). It also annotates the sets with their respective size. The annotations can be turned off with annotate=false.","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"analysis = ABCanalysis(data)\nplot(analysis)","category":"page"},{"location":"plotting/#","page":"Plotting","title":"Plotting","text":"(Image: )","category":"page"},{"location":"#CalculatedABC.jl-1","page":"Home","title":"CalculatedABC.jl","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"A Julia port of the ABCanalysis R package.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"From the documentation of the R package:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"For a given data set, the package provides a novel method of computing precise limits to acquire subsets which are easily interpreted. Closely related to the Lorenz curve, the ABC curve visualizes the data by graphically representing the cumulative distribution function. Based on an ABC analysis the algorithm calculates, with the help of the ABC curve, the optimal limits by exploiting the mathematical properties pertaining to distribution of analyzed items. The data containing positive values is divided into three disjoint subsets A, B and C, with subset A comprising very profitable values, i.e. largest data values (\"the important few\"), subset B comprising values where the yield equals to the effort required to obtain it, and the subset C comprising of non-profitable values, i.e., the smallest data sets (\"the trivial many\").","category":"page"},{"location":"#Installation-1","page":"Home","title":"Installation","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"CalculatedABC.jl is registered in the official registry of general Julia packages.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"To install the development version from a Julia REPL type ] to enter Pkg REPL mode and run","category":"page"},{"location":"#","page":"Home","title":"Home","text":"pkg> add https://github.com/ckafi/CalculatedABC.jl","category":"page"},{"location":"#License-1","page":"Home","title":"License","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"CalculatedABC.jl is licensed under the Apache License v2.0. For the full license text see LICENSE.","category":"page"},{"location":"#Acknowledgments-1","page":"Home","title":"Acknowledgments","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"This package is based on the paper Computed ABC Analysis for Rational Selection of Most Informative Variables in Multivariate Data by Ultsch A, Lötsch J (2015).","category":"page"},{"location":"abcanalysis/#ABC-Analysis-1","page":"ABC Analysis","title":"ABC Analysis","text":"","category":"section"},{"location":"abcanalysis/#Curve-1","page":"ABC Analysis","title":"Curve","text":"","category":"section"},{"location":"abcanalysis/#","page":"ABC Analysis","title":"ABC Analysis","text":"The basis for the ABC analysis is the ABCcurve struct. This curve is similar to the Lorenz curve and represents the effort of an element and its its relative cumulative yield in decreasing order of gain.","category":"page"},{"location":"abcanalysis/#","page":"ABC Analysis","title":"ABC Analysis","text":"ABCcurve","category":"page"},{"location":"abcanalysis/#CalculatedABC.ABCcurve","page":"ABC Analysis","title":"CalculatedABC.ABCcurve","text":"ABCcurve(data::Vector{<:Real})\n\nConstruct an ABCcurve from the given data.\n\nFields\n\neffort::AbstractRange: The effort as equidistant steps between 0 and 1.\nyield::Vector: The cumulative relative yield.\ninterpolation::AbstractInterpolation: A cubic spline interpolation of the curve.\n\n\n\n\n\n","category":"type"},{"location":"abcanalysis/#Analysis-1","page":"ABC Analysis","title":"Analysis","text":"","category":"section"},{"location":"abcanalysis/#","page":"ABC Analysis","title":"ABC Analysis","text":"An ABCanalysis struct takes either a data array or a previously calculated ABCcurve. It determines three points important for further analysis, the Pareto point, Break Even point and the Submarginal point. If you provide the raw data, it also gives back the indices of the elements in the sets A, B and C. For both curve and data input there are also convenience constructors ABCanalysis. ","category":"page"},{"location":"abcanalysis/#","page":"ABC Analysis","title":"ABC Analysis","text":"ABCanalysis4Curve\nABCanalysis4Data","category":"page"},{"location":"abcanalysis/#CalculatedABC.ABCanalysis4Curve","page":"ABC Analysis","title":"CalculatedABC.ABCanalysis4Curve","text":"ABCanalysis4Curve(curve::ABCcurve) <: ABCanalysis\n\nCalculate an ABC analysis for the given curve.\n\nFields\n\npareto: Nearest point to a theoretically ideal Break Even point.\nbreak_even: Point on the curve where the gain (dABC) is 1.\ndemark_AB: Point on the curve at which most of the yield is already obtained; the smaller of the Pareto and Break Even points. Demarkation between A and B.\nsubmarginal: Point on the curve after which the gain can be considered trivial. Demarkation between B and C.\ncurve: The given curve. Used for plotting.\n\n\n\n\n\n","category":"type"},{"location":"abcanalysis/#CalculatedABC.ABCanalysis4Data","page":"ABC Analysis","title":"CalculatedABC.ABCanalysis4Data","text":"ABCanalysis4Data(data::Vector{<:Real}) <: ABCanalysis\n\nCalculate an ABC analysis for the given data.\n\nFields\n\nExtends ABCanalysis4Curve with:\n\na_indices: Indices of elements in the A set.\nb_indices: Indices of elements in the B set.\nc_indices: Indices of elements in the C set.\n\n\n\n\n\n","category":"type"}]
}
