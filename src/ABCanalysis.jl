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
- `pareto`: Nearest point to a theoretically ideal Breal Even poin.
- `break_even`: Point on the curve where the gain (``dABC``) is 1.
- `demark_AB` Point on the curve at which most of the yield is already obtained; the smaller of the Pareto and Break Even points. Demarkation between *A* and *B*.
- `submarginal`: Point on the curve after which the gain can be considered trivial. Demarkation between *B* and *C*.
- `curve`: The given curve. Used for plotting.
"""
struct ABCanalysis
    pareto::Tuple{Float64, Float64}
    break_even::Tuple{Float64, Float64}
    demark_AB::Tuple{Float64, Float64}
    submarginal::Tuple{Float64, Float64}
    curve::ABCcurve

    function ABCanalysis(curve::ABCcurve)
        dist(p1,p2) = (p1 .- p2).^2 |> sum
        zipped_curve = zip(curve.effort, curve.yield)
        index_min_dist_point(p) = map(x -> dist(p,x), zipped_curve) |> argmin

        abc_ideal = (0,1)
        pareto_index = index_min_dist_point(abc_ideal)

        gradients = map(i->Interpolations.gradient(curve.interpolation, i)[1], curve.effort)
        break_even_index =  abs.(gradients .- 1) |> argmin
        break_even_ideal = (curve.effort[break_even_index], 1)

        submarginal_index = index_min_dist_point(break_even_ideal)

        (effort, yield) = (curve.effort, curve.yield)
        point(indx) = (effort[indx], yield[indx])
        demark_AB_index = min(pareto_index, break_even_index)

        new(point(pareto_index),
            point(break_even_index),
            point(demark_AB_index),
            point(submarginal_index),
            curve)
    end
end

# struct ABCanalysisOfData <: ABCanalysis
# end
