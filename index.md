## `dormancymetrics`: Curve Fitting for Seed Dormancy Release

![logo](https://raw.githubusercontent.com/aravind-j/dormancymetrics/master/inst/extdata/dormancymetrics.png)

###### Version : [0.0.0.9000](https://aravind-j.github.io/dormancymetrics/); License: [GPL-2\|GPL-3](https://www.r-project.org/Licenses/)

##### *Aravind, J¹, Viay, D², Manjunath Prasad, C. T.² and Suman Roy¹*

1.  Division of Germplasm Conservation, ICAR-National Bureau of Plant
    Genetic Resources, New Delhi.
2.  Division of Seed Science and Technology, ICAR-Indian Agricultural
    Research Institute, New Delhi.

------------------------------------------------------------------------

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-6666ff.svg?logo=R)](https://cran.r-project.org/)
[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Github Code
Size](https://img.shields.io/github/languages/code-size/aravind-j/dormancymetrics.svg)](https://github.com/aravind-j/dormancymetrics)
[![Project Status:
WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-maturing.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![Last-changedate](https://img.shields.io/badge/last%20change-2026--02--27-yellowgreen.svg)](https://github.com/aravind-j/dormancymetrics/)
[![Website -
pkgdown](https://img.shields.io/website-up-down-green-red/https/aravind-j.github.io/dormancymetrics.svg)](https://aravind-j.github.io/dormancymetrics/)

------------------------------------------------------------------------

## Description

Provides functions to fit non-linear regression curves such aslogistic
(Bentsink et al. 2010
\<[doi:10.1073/pnas.1000410107](https://doi.org/10.1073/pnas.1000410107)\>
and
2011\<[doi:bentsink_identification_2011](https://doi.org/bentsink_identification_2011)\>,
Postma et
al. 2015\<[doi:10.1111/mec.13061](https://doi.org/10.1111/mec.13061)\>)
and log-logistic models (Fogliatto et
al. 2020\<[doi:10.1080/11263504.2019.1578282](https://doi.org/10.1080/11263504.2019.1578282)\>)
to germination count data recorded atsequential time intervals of seed
storage. Facilitates estimation of keyparameters such as days of seed
dry storage required to reach 50%germination and rate of dormancy
release.

## Installation

The development version can be installed from github as follows:

``` r
# Install development version from Github
devtools::install_github("aravind-j/dormancymetrics")
```

## What’s new

To know whats new in this version type:

``` r
news(package='dormancymetrics')
```

## Links

[Github page](https://github.com/aravind-j/dormancymetrics)

[Documentation website](https://aravind-j.github.io/dormancymetrics/)

## Citing `dormancymetrics`

To cite the methods in the package use:

``` r
citation("dormancymetrics")
```

``` R
To cite package 'dormancymetrics' in publications use:

  Aravind J, Vijay D, Manjunath Prasad C, Roy S (2026).
  _dormancymetrics: Curve Fitting for Seed Dormancy Release_. R package
  version 0.0.0.9000, <https://github.com/aravind-j/dormancymetrics>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {dormancymetrics: Curve Fitting for Seed Dormancy Release},
    author = {J. Aravind and D. Vijay and C. T. {Manjunath Prasad} and Suman Roy},
    year = {2026},
    note = {R package version 0.0.0.9000},
    url = {https://github.com/aravind-j/dormancymetrics},
  }
```
