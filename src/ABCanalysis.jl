# Copyright [2019] [Tobias Frilling]
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

module ABCanalysis

using Interpolations

struct Curve
    effort::AbstractRange{Float64}
    yield::AbstractArray{<:Real,1}
    interpolation::AbstractInterpolation{<:Real,1,BSpline{Cubic{Line{OnGrid}}}}

    function Curve(data::AbstractArray{<:Real,1})
        @assert all(x -> x>=0, data)
        sorted_data = sort(data, rev = true)
        n = length(sorted_data)

        # (0,0) needs to be first point
        effort = (0:n) / n
        yield = pushfirst!(cumsum(sorted_data) / sum(sorted_data), 0)
        interpolation = CubicSplineInterpolation(effort, yield)

        new(effort, yield, interpolation)
    end
end

"""
    removeSmallYields(data, threshold=0.005)

Removes the smallest values from `data` whose cumulative yield is less than `threshold`. Does not preserve the order of `data`.
"""
function removeSmallYields(data::AbstractArray{<:Real,1}, threshold::Real = 0.005)
    perm = sortperm(data)
    sorted_data = data[perm]
    yield = cumsum(sorted_data) / sum(sorted_data)
    threshold_index = findfirst(x -> x > threshold, yield)
    data[perm[threshold_index:length(data)]]
end

"""
    gini(data::AbstractArray{<:Real,1})

Calculates the Gini coefficient for the given data.
"""
function gini(data::AbstractArray{<:Real,1})
  @assert all(x -> x>=0, data)
  y = sort(data)
  n = length(y)
  2 * sum([i*y[i] for i in 1:n]) / (n*sum(y)) - (n+1)/n
end
end # module
