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
    ABCcurve(data::AbstractArray{<:Real,1})

Construct an ABCcurve from the given data.

# Fields
- `effort::AbstractRange`: The effort as equidistant steps between 0 and 1.
- `yield::AbstractArray`: The cumulative relative yield.
- `interpolation::AbstractInterpolation`: A cubic spline interpolation of the curve.
"""
struct ABCcurve
    effort::AbstractRange{Float64}
    yield::AbstractArray{<:Real,1}
    interpolation::AbstractInterpolation{<:Real,1,BSpline{Cubic{Line{OnGrid}}}}

    function ABCcurve(data::AbstractArray{<:Real,1})
        @assert all(x->x >= 0, data)
        sorted_data = sort(data, rev = true)
        n = length(sorted_data)

        # (0,0) needs to be first point
        effort = (0:n) / n
        yield = pushfirst!(cumsum(sorted_data) / sum(sorted_data), 0)
        interpolation = CubicSplineInterpolation(effort, yield)

        new(effort, yield, interpolation)
    end
end


function Base.show(io::IO, ::MIME"text/plain", curve::ABCcurve)
    print(io, curve.effort |> length, "-element ABCcurve")
    limit::Bool = get(io, :limit, false)
    if limit
        rows = displaysize(io)[1] - 3
        rows < 2 && (print(io, " …"); return)
        rows -= 2
    else
        rows = typemax(Int)
    end

    show_part(iter) = for v in iter
        print(io, "\n ")
        show(io, v)
    end

    zipped_curve = collect(zip(curve.effort, curve.yield))

    if rows < length(zipped_curve)
        show_part(zipped_curve[1:div(rows-1,2)])
        print(io, "\n ⋮")
        show_part(zipped_curve[end-div(rows-1,2):end])
    else
        show_part(zipped_curve)
    end
end
