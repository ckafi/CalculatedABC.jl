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
    effort::Array{Float64,1}
    yield::Array{Float64,1}
    data::Array{Float64,1}
    itp::AbstractInterpolation{Float64,1,BSpline{Cubic{Line{OnGrid}}}}

    function Curve(data::Array{Float64,1})
        sorted_data = sort(data, rev = true)
        n = length(sorted_data)

        effort = (1:n) / n
        yield = cumsum(sorted_data) / sum(sorted_data)
        itp = CubicSplineInterpolation(effort, yield)

        new(collect(effort), yield, data, itp)
    end
end

end # module
