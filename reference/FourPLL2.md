# Four paramter log-logistic (with implicit inflection point)

To be used by
[`FourPLfit`](https://aravind-j.github.io/dormancymetrics/reference/FourPLfit.md).

## Usage

``` r
FourPLL2(x, a, bta, k, y0)

FourPLL2_fixa(x, a = 100, bta, k, y0)

FourPLL2_fixy0(x, a, bta, k)

FourPLL2_fixa_fixy0(x, a = 100, bta, k)

FourPLL2_deriv(x, y0, a, b, k)
```

## Arguments

- x:

  The explanatory/independent variable value.

- a:

  Parameter \\a\\.

- bta:

  Parameter \\\beta\\ where \\b = e^{\beta}\\.

- k:

  Parameter \\k\\.

- y0:

  Parameter \\y\_{0}\\.

- b:

  Parameter \\b\\.

## Value

The calculated response/dependent value value.
