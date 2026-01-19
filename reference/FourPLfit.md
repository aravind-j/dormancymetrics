# Fit four-parameter logistic or log-logistic function

Fit a four-parameter logistic or log-logistic function (Bentsink et al.
2010; Bentsink and Koornneef 2011; Postma and Agren 2015; Fogliatto et
al. 2020) to germination count data recorded at sequential time
intervals of seed storage to model a dormancy release curve and compute
the associated parameters.

## Usage

``` r
FourPLfit(
  germ.counts,
  intervals,
  rep,
  total.seeds,
  fix.y0 = TRUE,
  fix.a = TRUE,
  inflection.point = c("explicit", "implicit"),
  time.scale = c("linear", "log"),
  tmax = max(intervals),
  tries = 3
)
```

## Arguments

- germ.counts:

  Germination counts at each time interval (days of seed storage) as a
  numeric vector.

- intervals:

  Time intervals of seed storage as a numeric vector.

- rep:

  Optional. An integer vector indicating the replication corresponding
  to each germination count.

- total.seeds:

  Total number of seeds as an integer vector of unit length.

- fix.y0:

  Force the intercept of the y axis through 0.

- fix.a:

  Fix a as the actual maximum germination percentage at the end of the
  experiment.

- inflection.point:

  Either `"explicit"` or `"implicit"`. See **Details**.

- time.scale:

  Either `"linear"` for fitting a four-parameter logistic function or
  `"logarithmic"` for fitting a four-parameter log-logistic function.

- tmax:

  The time interval up to which AUC is to be computed.

- tries:

  The number of tries to be attempted to fit the curve. Default is 3.

## Value

A list with the following components:

- data:

  A data frame with the data used for computing the model.

- Parameters:

  A data frame of parameter estimates, standard errors and p value.

- Fit:

  A one-row data frame with estimates of model fitness such as log
  likelyhoods, Akaike Information Criterion, Bayesian Information
  Criterion, deviance and residual degrees of freedom.

- a:

  The upper asymptote, or maximum germination percentage.

- b:

  The mathematical parameter controlling the shape and steepness of the
  dormancy release curve.

- c:

  The inflection point which represents the time point of storage with
  maximum rate of dormancy release.

- y0:

  The lower asymptote, or intercept on the y axis.

- TMRDR:

  Time at maximum rate of dormancy release.

- AUC:

  The estimate of area under the curve.

- msg:

  The message from
  [`gsl_nls`](https://rdrr.io/pkg/gslnls/man/gsl_nls.html).

- isConv:

  Logical value indicating whether convergence was achieved.

- model:

  The raw fitted model output as a list of class `gsl_nls`.

## Details

The germination count data of a seed lot recorded at sequential time
intervals of storage can be modelled to fit a **four-parameter
logistic** function defined as follows (Bentsink et al. 2010; Bentsink
and Koornneef 2011) .

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + e^{-b(x - c)}}\\

Where, \\y\\ is the germination percentage at the \\x\\ time interval
after storage, \\y\_{0}\\ is the lower asymptote, or intercept on the y
axis, \\a\\ is the upper asymptote, or maximum germination percentage,
\\b\\ is a mathematical parameter controlling the shape and steepness of
the dormancy release curve (the larger the \\b\\ parameter, the steeper
the rise toward the asymptote \\a\\, and the shorter the time between
initial germination value and maximum germination), and \\c\\ is the
inflection point which represents the time point of storage with maximum
rate of dormancy release. \\c\\ is the \\DSDS\_{50}\\ (days of seed dry
storage required to reach 50% germination). It is also described as the
depth of dormancy or \\AR\_{50}\\ (dry after-ripening time required to
achieve 50% germination).

This model has the inflection point \\c\\ explicitly included.
Alternatively the data can also be modelled to fit a four-parameter
logistic function with implicit inflection point (Postma and Agren 2015)
defined as follows.

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + k \cdot e^{-b \cdot x}}\\

Where, \\k\\ controls the initial value of the function at \\x = 0\\. It
determines the initial steepness and starting value of the curve. It is
the asymmetry or horizontal shift factor which affects where the curve
reaches its inflection point and introduces asymmetry.

\\k = e^{-bc} \\ \textrm{and} \\ c = -\frac{\ln{k}}{b}\\

This is useful in cases where more than 50% germination is achieved in
the first time interval itself.

This model is more suitable where the dormancy release over a linear
time scale is smooth and symmetrical. In cases of rapid early dormancy
release with a long tail of the curve, a **log-logistic model** is more
appropriate (Fogliatto et al. 2020) . Here the time \\x\\ is scaled
logarithmically.

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + e^{-b(\log(x) - \log(c))}}\\

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + k \cdot x^{b}} \\ \left
(\textrm{As} \\ e^{b \cdot \log(x)} = x^{b} \right )\\

In `FourPLfit`, these models have been reparameterized by substituting
\\b\\ with \\e^{\beta}\\ to constraint \\b\\ to positive values only.

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + e^{-e^{\beta}(x - c)}}\\

\\y(x) = y_0 + \frac{a - y\_{0}}{1 + k \cdot e^{-e^{\beta} \cdot x}}\\

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + e^{-e^{\beta}(\log(x) -
\log(c))}}\\

\\y(x) = y\_{0} + \frac{a - y\_{0}}{1 + k \cdot x^{e^{\beta}}}\\

## References

Bentsink L, Hanson J, Hanhart CJ, Blankestijn-de Vries H, Coltrane C,
Keizer P, El-Lithy M, Alonso-Blanco C, de Andres MT, Reymond M, van
Eeuwijk F, Smeekens S, Koornneef M (2010). “Natural variation for seed
dormancy in Arabidopsis is regulated by additive genetic and molecular
pathways.” *Proceedings of the National Academy of Sciences*,
**107**(9), 4264–4269.  
  
Bentsink L, Koornneef M (2011). “Identification and characterization of
quantitative trait loci that control seed dormancy in *Arabidopsis*.” In
*Seed Dormancy: Methods and Protocols*, 165–184. Springer. ISBN
1-61779-230-6.  
  
Fogliatto S, Milan M, De Palo F, Vidotto F (2020). “The effect of
various after-ripening temperature regimens on the germination behaviour
of *Ambrosia artemisiifolia*.” *Plant Biosystems - an International
Journal Dealing with All Aspects of Plant Biology*, **154**(2),
165–172.  
  
Postma FM, Agren J (2015). “Maternal environment affects the genetic
basis of seed dormancy in *Arabidopsis thaliana*.” *Molecular Ecology*,
**24**(4), 785–797.

## Examples

``` r
x <- c(2, 1, 2, 2, 0, 0, 2, 2, 0, 2, 2, 0, 2, 2, 2, 6, 8, 10, 8, 19,
       8, 4, 11, 4, 22, 19, 25, 16, 21, 30, 40, 33, 34, 36, 44, 42,
       42, 39, 42, 38, 47, 42, 50, 44, 48, 50)
y <- c(0, 0, 14, 14, 18, 18, 20, 20, 21, 21, 22, 22, 23, 23, 23, 23,
       24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 26, 26, 26, 26,
       26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27)
rep <- rep(1:2, 23)
int <- rep(c(0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 31, 35, 39, 43, 47, 52,
             57, 62, 67, 72, 82, 92, 102), each = 2)
total.seeds = 50

# Logistic fit
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FourPLfit(germ.counts = x, intervals = int, rep = rep, total.seeds = 50,
          fix.y0 = TRUE, fix.a = TRUE,
          inflection.point = "explicit", time.scale = "linear")
#> Warning: 'intervals' are not uniform.
#> $data
#>     gp rep intervals
#> 1    4   1         0
#> 2    2   2         0
#> 3    4   1         3
#> 4    4   2         3
#> 5    0   1         6
#> 6    0   2         6
#> 7    4   1         9
#> 8    4   2         9
#> 9    0   1        12
#> 10   4   2        12
#> 11   4   1        15
#> 12   0   2        15
#> 13   4   1        18
#> 14   4   2        18
#> 15   4   1        21
#> 16  12   2        21
#> 17  16   1        24
#> 18  20   2        24
#> 19  16   1        27
#> 20  38   2        27
#> 21  16   1        31
#> 22   8   2        31
#> 23  22   1        35
#> 24   8   2        35
#> 25  44   1        39
#> 26  38   2        39
#> 27  50   1        43
#> 28  32   2        43
#> 29  42   1        47
#> 30  60   2        47
#> 31  80   1        52
#> 32  66   2        52
#> 33  68   1        57
#> 34  72   2        57
#> 35  88   1        62
#> 36  84   2        62
#> 37  84   1        67
#> 38  78   2        67
#> 39  84   1        72
#> 40  76   2        72
#> 41  94   1        82
#> 42  84   2        82
#> 43 100   1        92
#> 44  88   2        92
#> 45  96   1       102
#> 46 100   2       102
#> 
#> $Parameters
#>   term  estimate  std.error statistic      p.value
#> 1  bta -2.442148 0.07540735 -32.38607 2.476476e-32
#> 2    c 46.407609 0.98287454  47.21621 2.460476e-39
#> 
#> $Fit
#>      sigma isConv       finTol    logLik      AIC      BIC deviance df.residual
#> 1 7.903799   TRUE 9.094947e-13 -159.3466 324.6932 330.1791 2748.681          44
#>   nobs
#> 1   46
#> 
#> $a
#> [1] 100
#> 
#> $b
#> [1] 0.08697383
#> 
#> $c
#> [1] 46.40761
#> 
#> $k
#> [1] NA
#> 
#> $y0
#> [1] 0
#> 
#> $TMRDR
#> [1] 46.40762
#> 
#> $AUC
#> [1] 5548.207
#> 
#> $msg
#> [1] "#1. success "
#> 
#> $isConv
#> [1] TRUE
#> 
#> $model
#> Nonlinear regression model
#>   model: gp ~ FourPL1_fixa_fixy0(x = intervals, a = max(gp), bta, c)
#>    data: data
#>    bta      c 
#> -2.442 46.408 
#>  residual sum-of-squares: 2749
#> 
#> Algorithm: multifit/levenberg-marquardt, (scaling: levenberg, solver: qr)
#> 
#> Number of iterations to convergence: 9 
#> Achieved convergence tolerance: 9.095e-13
#> 
#> attr(,"class")
#> [1] "FourPLfit" "list"     
#> attr(,"inflection.point")
#> [1] "explicit"
#> attr(,"time.scale")
#> [1] "linear"

FourPLfit(germ.counts = x, intervals = int, rep = rep, total.seeds = 50,
          fix.y0 = TRUE, fix.a = TRUE,
          inflection.point = "implicit", time.scale = "linear")
#> Warning: 'intervals' are not uniform.
#> $data
#>     gp rep intervals
#> 1    4   1         0
#> 2    2   2         0
#> 3    4   1         3
#> 4    4   2         3
#> 5    0   1         6
#> 6    0   2         6
#> 7    4   1         9
#> 8    4   2         9
#> 9    0   1        12
#> 10   4   2        12
#> 11   4   1        15
#> 12   0   2        15
#> 13   4   1        18
#> 14   4   2        18
#> 15   4   1        21
#> 16  12   2        21
#> 17  16   1        24
#> 18  20   2        24
#> 19  16   1        27
#> 20  38   2        27
#> 21  16   1        31
#> 22   8   2        31
#> 23  22   1        35
#> 24   8   2        35
#> 25  44   1        39
#> 26  38   2        39
#> 27  50   1        43
#> 28  32   2        43
#> 29  42   1        47
#> 30  60   2        47
#> 31  80   1        52
#> 32  66   2        52
#> 33  68   1        57
#> 34  72   2        57
#> 35  88   1        62
#> 36  84   2        62
#> 37  84   1        67
#> 38  78   2        67
#> 39  84   1        72
#> 40  76   2        72
#> 41  94   1        82
#> 42  84   2        82
#> 43 100   1        92
#> 44  88   2        92
#> 45  96   1       102
#> 46 100   2       102
#> 
#> $Parameters
#>   term  estimate   std.error  statistic      p.value
#> 1  bta -2.442148  0.07540736 -32.386068 2.476491e-32
#> 2    k 56.613503 17.15193195   3.300707 1.918390e-03
#> 
#> $Fit
#>      sigma isConv finTol    logLik      AIC      BIC deviance df.residual nobs
#> 1 7.903799   TRUE      0 -159.3466 324.6932 330.1791 2748.681          44   46
#> 
#> $a
#> [1] 100
#> 
#> $b
#> [1] 0.08697383
#> 
#> $c
#> [1] NA
#> 
#> $k
#> [1] 56.6135
#> 
#> $y0
#> [1] 0
#> 
#> $TMRDR
#> [1] 46.40762
#> 
#> $AUC
#> [1] 5548.207
#> 
#> $msg
#> [1] "#1. success "
#> 
#> $isConv
#> [1] TRUE
#> 
#> $model
#> Nonlinear regression model
#>   model: gp ~ FourPL2_fixa_fixy0(x = intervals, a = max(gp), bta, k)
#>    data: data
#>    bta      k 
#> -2.442 56.614 
#>  residual sum-of-squares: 2749
#> 
#> Algorithm: multifit/levenberg-marquardt, (scaling: levenberg, solver: qr)
#> 
#> Number of iterations to convergence: 33 
#> Achieved convergence tolerance: 0
#> 
#> attr(,"class")
#> [1] "FourPLfit" "list"     
#> attr(,"inflection.point")
#> [1] "implicit"
#> attr(,"time.scale")
#> [1] "linear"

# Log-logistic fit
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FourPLfit(germ.counts = y, intervals = int, rep = rep, total.seeds = 50,
          fix.y0 = TRUE, fix.a = TRUE,
          inflection.point = "explicit", time.scale = "log")
#> Warning: 'intervals' are not uniform.
#> $data
#>    gp rep intervals
#> 1   0   1         0
#> 2   0   2         0
#> 3  28   1         3
#> 4  28   2         3
#> 5  36   1         6
#> 6  36   2         6
#> 7  40   1         9
#> 8  40   2         9
#> 9  42   1        12
#> 10 42   2        12
#> 11 44   1        15
#> 12 44   2        15
#> 13 46   1        18
#> 14 46   2        18
#> 15 46   1        21
#> 16 46   2        21
#> 17 48   1        24
#> 18 48   2        24
#> 19 48   1        27
#> 20 48   2        27
#> 21 50   1        31
#> 22 50   2        31
#> 23 50   1        35
#> 24 50   2        35
#> 25 50   1        39
#> 26 50   2        39
#> 27 50   1        43
#> 28 50   2        43
#> 29 52   1        47
#> 30 52   2        47
#> 31 52   1        52
#> 32 52   2        52
#> 33 52   1        57
#> 34 52   2        57
#> 35 52   1        62
#> 36 52   2        62
#> 37 54   1        67
#> 38 54   2        67
#> 39 54   1        72
#> 40 54   2        72
#> 41 54   1        82
#> 42 54   2        82
#> 43 54   1        92
#> 44 54   2        92
#> 45 54   1       102
#> 46 54   2       102
#> 
#> $Parameters
#>   term   estimate  std.error statistic      p.value
#> 1  bta 0.03454928 0.03104337  1.112936 2.717795e-01
#> 2    c 3.09505151 0.13815722 22.402387 1.084477e-25
#> 
#> $Fit
#>      sigma isConv       finTol    logLik      AIC     BIC deviance df.residual
#> 1 1.123308   TRUE 7.105427e-14 -69.59755 145.1951 150.681 55.52009          44
#>   nobs
#> 1   46
#> 
#> $a
#> [1] 54
#> 
#> $b
#> [1] 1.035153
#> 
#> $c
#> [1] 3.095052
#> 
#> $k
#> [1] NA
#> 
#> $y0
#> [1] 0
#> 
#> $TMRDR
#> [1] 3.09504
#> 
#> $AUC
#> [1] 4945.616
#> 
#> $msg
#> [1] "#1. success "
#> 
#> $isConv
#> [1] TRUE
#> 
#> $model
#> Nonlinear regression model
#>   model: gp ~ FourPLL1_fixa_fixy0(x = intervals, a = max(gp), bta, c)
#>    data: data
#>     bta       c 
#> 0.03455 3.09505 
#>  residual sum-of-squares: 55.52
#> 
#> Algorithm: multifit/levenberg-marquardt, (scaling: levenberg, solver: qr)
#> 
#> Number of iterations to convergence: 10 
#> Achieved convergence tolerance: 7.105e-14
#> 
#> attr(,"class")
#> [1] "FourPLfit" "list"     
#> attr(,"inflection.point")
#> [1] "explicit"
#> attr(,"time.scale")
#> [1] "log"

FourPLfit(germ.counts = y, intervals = int, rep = rep, total.seeds = 50,
          fix.y0 = TRUE, fix.a = TRUE,
          inflection.point = "implicit", time.scale = "log")
#> Warning: 'intervals' are not uniform.
#> $data
#>    gp rep intervals
#> 1   0   1         0
#> 2   0   2         0
#> 3  28   1         3
#> 4  28   2         3
#> 5  36   1         6
#> 6  36   2         6
#> 7  40   1         9
#> 8  40   2         9
#> 9  42   1        12
#> 10 42   2        12
#> 11 44   1        15
#> 12 44   2        15
#> 13 46   1        18
#> 14 46   2        18
#> 15 46   1        21
#> 16 46   2        21
#> 17 48   1        24
#> 18 48   2        24
#> 19 48   1        27
#> 20 48   2        27
#> 21 50   1        31
#> 22 50   2        31
#> 23 50   1        35
#> 24 50   2        35
#> 25 50   1        39
#> 26 50   2        39
#> 27 50   1        43
#> 28 50   2        43
#> 29 52   1        47
#> 30 52   2        47
#> 31 52   1        52
#> 32 52   2        52
#> 33 52   1        57
#> 34 52   2        57
#> 35 52   1        62
#> 36 52   2        62
#> 37 54   1        67
#> 38 54   2        67
#> 39 54   1        72
#> 40 54   2        72
#> 41 54   1        82
#> 42 54   2        82
#> 43 54   1        92
#> 44 54   2        92
#> 45 54   1       102
#> 46 54   2       102
#> 
#> $Parameters
#>   term   estimate  std.error statistic      p.value
#> 1  bta 0.03454924 0.03104336  1.112935 2.717798e-01
#> 2    k 3.22044816 0.25133902 12.813165 1.893391e-16
#> 
#> $Fit
#>      sigma isConv       finTol    logLik      AIC     BIC deviance df.residual
#> 1 1.123308   TRUE 6.394885e-14 -69.59755 145.1951 150.681 55.52009          44
#>   nobs
#> 1   46
#> 
#> $a
#> [1] 54
#> 
#> $b
#> [1] 1.035153
#> 
#> $c
#> [1] NA
#> 
#> $k
#> [1] 3.220448
#> 
#> $y0
#> [1] 0
#> 
#> $TMRDR
#> [1] 3.095039
#> 
#> $AUC
#> [1] 4945.616
#> 
#> $msg
#> [1] "#1. success "
#> 
#> $isConv
#> [1] TRUE
#> 
#> $model
#> Nonlinear regression model
#>   model: gp ~ FourPLL2_fixa_fixy0(x = intervals, a = max(gp), bta, k)
#>    data: data
#>     bta       k 
#> 0.03455 3.22045 
#>  residual sum-of-squares: 55.52
#> 
#> Algorithm: multifit/levenberg-marquardt, (scaling: levenberg, solver: qr)
#> 
#> Number of iterations to convergence: 18 
#> Achieved convergence tolerance: 6.395e-14
#> 
#> attr(,"class")
#> [1] "FourPLfit" "list"     
#> attr(,"inflection.point")
#> [1] "implicit"
#> attr(,"time.scale")
#> [1] "log"
```
