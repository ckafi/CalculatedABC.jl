# Copyright 2019 Tobias Frilling
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
    ABCanalysis(curve::ABCcurve)

Calculate an ABC analysis for the given curve.

# Fields
- `pareto*point`: Point on the curve at which most of the yield is already obtained. Demarkation between *A* and *B*.
- `break*even*point`: Point on the curve where the gain (``dABC``) is 1.
- `submarginal*point`: Point on the curve after which the gain can be considered trivial. Demarkation between *B* and *C*.
"""
struct ABCanalysis
    pareto_point::Tuple{Float64, Float64}
    break_even_point::Tuple{Float64, Float64}
    submarginal_point::Tuple{Float64, Float64}

    function ABCanalysis(curve::ABCcurve)
        dist(p1,p2) = (p1 .- p2).^2 |> sum
        zipped_curve = zip(curve.effort, curve.yield)
        index_min_dist_point(p) = map(x -> dist(p,x), zipped_curve) |> argmin

        abc_ideal_point = (0,1)
        pareto_point_index = index_min_dist_point(abc_ideal_point)

        gradients = map(i->Interpolations.gradient(curve.interpolation, i)[1], curve.effort)
        break_even_point_index =  abs.(gradients .- 1) |> argmin
        break_even_point = (curve.effort[break_even_point_index], 1)

        submarginal_point_index = index_min_dist_point(break_even_point)

        new((effort[pareto_point_index], yield[pareto_point_index]),
            (effort[break_even_point_index], yield[break_even_point_index]),
            (effort[submarginal_point_index], yield[submarginal_point_index]))
    end
end

# struct ABCanalysisOfData <: ABCanalysis
# end
