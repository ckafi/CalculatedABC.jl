# Gini coefficient
The Gini coefficient is a single number aimed at measuring the degree of inequality in a distribution. It is usually defined mathematically based on the Lorenz curve. A Gini coefficient of zero expresses perfect equality, where all values are the same, whereas a coefficient of 1 expresses maximal inequality among values.

```@docs
gini_coeff(data::AbstractArray{<:Real,1})
gini_coeff(curve::ABCcurve)
```
