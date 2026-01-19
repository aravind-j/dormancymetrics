# Four parameter log-logistic (with explicit inflection point)

To be used by
[`FourPLfit`](https://aravind-j.github.io/dormancymetrics/reference/FourPLfit.md).

## Usage

``` r
FourPLL1(x, a, bta, c, y0)

FourPLL1_fixa(x, a = 100, bta, c, y0)

FourPLL1_fixy0(x, a, bta, c)

FourPLL1_fixa_fixy0(x, a = 100, bta, c)

FourPLL1_deriv(x, y0, a, b, c)
```

## Arguments

- x:

  The explanatory/independent variable value.

- a:

  Parameter \\a\\.

- bta:

  Parameter \\\beta\\ where \\b = e^{\beta}\\.

- c:

  Parameter \\c\\.

- y0:

  Parameter \\y\_{0}\\.

- b:

  Parameter \\b\\.

## Value

The calculated response/dependent value value.
