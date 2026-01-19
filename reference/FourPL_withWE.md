# Function/model selection helper with `trycatch`

Not exported. Strictly internal

## Usage

``` r
FourPL_withWE(
  data,
  fix.a,
  fix.y0,
  starta,
  startbta,
  startc,
  startk,
  starty0,
  maxiter,
  algorithm = "lm",
  warnOnly = FALSE,
  inflection.point = c("explicit", "implicit"),
  time.scale = c("linear", "log")
)
```

## Arguments

- fix.a:

  Fix a as the actual maximum germination percentage at the end of the
  experiment.

- fix.y0:

  Force the intercept of the y axis through 0.

- inflection.point:

  Either `"explicit"` or `"implicit"`. See **Details**.

- time.scale:

  Either `"linear"` for fitting a four-parameter logistic function or
  `"logarithmic"` for fitting a four-parameter log-logistic function.
