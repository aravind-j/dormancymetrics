
<!-- 
<img src="https://raw.githubusercontent.com/aravind-j/dormancymetrics/master/inst/extdata/dormancymetrics.png" alt="" width="20%" />
-->

## `dormancymetrics`: Curve Fitting for Seed Dormancy Release

<img src="https://raw.githubusercontent.com/aravind-j/dormancymetrics/master/inst/extdata/dormancymetrics.png" align="right" alt="logo" width="173" height = "200" style = "border: none; float: right;">

###### Version : [0.0.0.9000](https://aravind-j.github.io/dormancymetrics/); License: [GPL-2\|GPL-3](https://www.r-project.org/Licenses/)

##### *Aravind, J<sup>1</sup>, Viay, D<sup>2</sup>, Manjunath Prasad, C. T.<sup>2</sup> and Suman Roy<sup>1</sup>*

1.  Division of Germplasm Conservation, ICAR-National Bureau of Plant
    Genetic Resources, New Delhi.
2.  Division of Seed Science and Technology, ICAR-Indian Agricultural
    Research Institute, New Delhi.

------------------------------------------------------------------------

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-6666ff.svg?logo=R)](https://cran.r-project.org/)
[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
<!-- [![CRAN_Status_Badge](https://www.r-pkg.org/badges/version-last-release/dormancymetrics)](https://cran.r-project.org/package=dormancymetrics)
[![Dependencies](https://tinyverse.netlify.app/status/dormancymetrics)](https://cran.r-project.org/package=dormancymetrics) -->
<!-- [![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/dormancymetrics?color=green)](https://CRAN.R-project.org/package=dormancymetrics) -->
<!-- 
[![develVersion](https://img.shields.io/badge/devel%20version-0.0.0.9000-orange.svg)](https://github.com/aravind-j/dormancymetrics)
--> [![Github Code
Size](https://img.shields.io/github/languages/code-size/aravind-j/dormancymetrics.svg)](https://github.com/aravind-j/dormancymetrics)
<!-- [![R-CMD-check](https://github.com/aravind-j/dormancymetrics/workflows/R-CMD-check/badge.svg)](https://github.com/aravind-j/dormancymetrics/actions) -->
[![Project Status:
WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-maturing.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![Last-changedate](https://img.shields.io/badge/last%20change-2026--02--27-yellowgreen.svg)](https://github.com/aravind-j/dormancymetrics/)
<!-- [![Zenodo DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.zenodo.14889174.svg)](https://doi.org/10.5281/zenodo.14889174) -->
[![Website -
pkgdown](https://img.shields.io/website-up-down-green-red/https/aravind-j.github.io/dormancymetrics.svg)](https://aravind-j.github.io/dormancymetrics/)
<!-- [![.](https://pro-pulsar-193905.appspot.com/G-xxxxxxxx/welcome-page)](https://github.com/aravind-j/google-analytics-beacon) -->
<!-- [![GoatCounter](https://dormancymetrics-gh.goatcounter.com/count?p=/test)](https://dormancymetrics.goatcounter.com/)  -->
<!-- [![packageversion](https://img.shields.io/badge/Package%20version-0.2.3.3-orange.svg)](https://github.com/aravind-j/dormancymetrics) -->
<!-- [![GitHub Download Count](https://github-basic-badges.herokuapp.com/downloads/aravind-j/dormancymetrics/total.svg)] -->
<!-- [![Rdoc](http://www.rdocumentation.org/badges/version/dormancymetrics)](http://www.rdocumentation.org/packages/dormancymetrics) -->

------------------------------------------------------------------------

## Description

<!-- Provides functions to fit non-linear regression curves such as logistic (Bentsink et al. 2010 [doi:10.1073/pnas.1000410107> and 2011 <doi:bentsink_identification_2011>, Postma et al. 2015 <doi:10.1111/mec.13061>) and log-logistic models (Fogliatto et al. 2020 <doi:10.1080/11263504.2019.1578282](https://doi.org/10.1073/pnas.1000410107> and 2011 <doi:bentsink_identification_2011>, Postma et al. 2015 <doi:10.1111/mec.13061>) and log-logistic models (Fogliatto et al. 2020 <doi:10.1080/11263504.2019.1578282)) to germination count data recorded at sequential time intervals of seed storage. Facilitates estimation of key parameters such as days of seed dry storage required to reach 50% germination and rate of dormancy release. -->

Provides functions to fit non-linear regression curves such aslogistic
(Bentsink et al. 2010
\<<a href='https://doi.org/10.1073/pnas.1000410107'>doi:10.1073/pnas.1000410107</a>\>
and
2011\<<a href='https://doi.org/bentsink_identification_2011'>doi:bentsink_identification_2011</a>\>,
Postma et
al. 2015\<<a href='https://doi.org/10.1111/mec.13061'>doi:10.1111/mec.13061</a>\>)
and log-logistic models (Fogliatto et
al. 2020\<<a href='https://doi.org/10.1080/11263504.2019.1578282'>doi:10.1080/11263504.2019.1578282</a>\>)
to germination count data recorded atsequential time intervals of seed
storage. Facilitates estimation of keyparameters such as days of seed
dry storage required to reach 50%germination and rate of dormancy
release.

## Installation

<!-- 
The package can be installed from CRAN as follows: 
&#10;
-->

The development version can be installed from github as follows:

``` r
# Install development version from Github
devtools::install_github("aravind-j/dormancymetrics")
```

<!-- ## Detailed tutorial
For a detailed tutorial (vignette) on how to used this package type:
&#10;
``` r
browseVignettes(package = 'dormancymetrics')
```
The vignette for the latest version is also available [online](https://aravind-j.github.io/dormancymetrics/articles.html).-->

## What’s new

To know whats new in this version type:

``` r
news(package='dormancymetrics')
```

## Links

<!--[CRAN page](https://cran.r-project.org/package=dormancymetrics) -->

[Github page](https://github.com/aravind-j/dormancymetrics)

[Documentation website](https://aravind-j.github.io/dormancymetrics/)

<!--[Zenodo DOI](https://doi.org/10.5281/zenodo.14889174) -->
<!--
## CRAN checks
&#10;
&#10;
&#10; [![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://cran.r-project.org/web/checks/check_results_dormancymetrics.html) 
&#10;
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flavour                           | CRAN check                                                                                                                                                                                                          |
+===================================+=====================================================================================================================================================================================================================+
| r-devel-linux-x86_64-debian-clang | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-devel-linux-x86_64-debian-clang](https://badges.cranchecks.info/flavor/r-devel-linux-x86_64-debian-clang/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html) |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-devel-linux-x86_64-debian-gcc   | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-devel-linux-x86_64-debian-gcc](https://badges.cranchecks.info/flavor/r-devel-linux-x86_64-debian-gcc/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)     |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-devel-linux-x86_64-fedora-clang | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-devel-linux-x86_64-fedora-clang](https://badges.cranchecks.info/flavor/r-devel-linux-x86_64-fedora-clang/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html) |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-devel-linux-x86_64-fedora-gcc   | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-devel-linux-x86_64-fedora-gcc](https://badges.cranchecks.info/flavor/r-devel-linux-x86_64-fedora-gcc/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)     |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-patched-linux-x86_64            | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-patched-linux-x86_64](https://badges.cranchecks.info/flavor/r-patched-linux-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)                       |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-release-linux-x86_64            | [![CRAN check -                                                                                                                                                                                                     |
|                                   | r-release-linux-x86_64](https://badges.cranchecks.info/flavor/r-release-linux-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)                       |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
&#10;
 [![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://cran.r-project.org/web/checks/check_results_dormancymetrics.html) 
&#10;
+--------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flavour                  | CRAN check                                                                                                                                                                                        |
+==========================+===================================================================================================================================================================================================+
| r-devel-windows-x86_64   | [![CRAN check -                                                                                                                                                                                   |
|                          | r-devel-windows-x86_64](https://badges.cranchecks.info/flavor/r-devel-windows-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)     |
+--------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-release-windows-x86_64 | [![CRAN check -                                                                                                                                                                                   |
|                          | r-release-windows-x86_64](https://badges.cranchecks.info/flavor/r-release-windows-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html) |
+--------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-oldrel-windows-x86_64  | [![CRAN check -                                                                                                                                                                                   |
|                          | r-oldrel-windows-x86_64](https://badges.cranchecks.info/flavor/r-oldrel-windows-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)   |
+--------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
&#10;
 [![MacOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)](https://cran.r-project.org/web/checks/check_results_dormancymetrics.html) 
&#10;
+------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Flavour                | CRAN check                                                                                                                                                                                    |
+========================+===============================================================================================================================================================================================+
| r-release-macos-x86_64 | [![CRAN check -                                                                                                                                                                               |
|                        | r-release-macos-x86_64](https://badges.cranchecks.info/flavor/r-release-macos-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html) |
+------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| r-oldrel-macos-x86_64  | [![CRAN check -                                                                                                                                                                               |
|                        | r-oldrel-macos-x86_64](https://badges.cranchecks.info/flavor/r-oldrel-macos-x86_64/dormancymetrics.svg)](https://cran.r-project.org/web/checks/check_results_j.aravind_at_icar.org.in.html)   |
+------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-->

## Citing `dormancymetrics`

To cite the methods in the package use:

``` r
citation("dormancymetrics")
```

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
