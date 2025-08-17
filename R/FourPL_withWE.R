
#' Function/model selection helper with \code{trycatch}
#'
#' Not exported. Strictly internal
#'
#' @keywords internal
#'
#' @inheritParams FourPLfit
#
FourPL_withWE <- function(data,
                          fix.a, fix.y0,
                          starta, startbta, startc, startk, starty0,
                          maxiter, algorithm = "lm", warnOnly = FALSE,
                          inflection.point = c("explicit", "implicit"),
                          time.scale = c("linear", "log")) {

  inflection.point <- match.arg(inflection.point)
  time.scale <- match.arg(time.scale)

  if (inflection.point == "explicit") {
    if (time.scale == "linear") {
      out <- tryCatch(

        if (TRUE %in% c(fix.y0, fix.a)) {

          if (fix.a == FALSE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPL1_fixy0(x = intervals, a, bta, c),
              data = data,
              algorithm = algorithm,
              start = list(a = starta, bta = startbta, c = startc),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == FALSE) {

            gsl_nls(
              gp ~ FourPL1_fixa(x = intervals, a = max(gp), bta, c, y0),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, c = startc, y0 = starty0),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPL1_fixa_fixy0(x = intervals, a = max(gp),
                                      bta, c),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, c = startc),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))
          }

        } else {

          gsl_nls(
            gp ~ FourPL1(x = intervals, a, bta, c, y0),
            data = data,
            algorithm = algorithm,
            start = list(a = starta, bta = startbta,
                         c = startc, y0 = starty0),
            control = list(maxiter = maxiter, warnOnly = warnOnly,
                           scale = "levenberg"))

        },

        error = function(e) e)
    }

    if (time.scale == "log") {
      out <- tryCatch(

        if (TRUE %in% c(fix.y0, fix.a)) {

          if (fix.a == FALSE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPLL1_fixy0(x = intervals, a, bta, c),
              data = data,
              algorithm = algorithm,
              start = list(a = starta, bta = startbta, c = startc),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == FALSE) {

            gsl_nls(
              gp ~ FourPLL1_fixa(x = intervals, a = max(gp), bta, c, y0),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, c = startc, y0 = starty0),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPLL1_fixa_fixy0(x = intervals, a = max(gp),
                                       bta, c),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, c = startc),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))
          }

        } else {

          gsl_nls(
            gp ~ FourPLL1(x = intervals, a, bta, c, y0),
            data = data,
            algorithm = algorithm,
            start = list(a = starta, bta = startbta,
                         c = startc, y0 = starty0),
            control = list(maxiter = maxiter, warnOnly = warnOnly,
                           scale = "levenberg"))

        },

        error = function(e) e)
    }
  }

  if (inflection.point == "implicit") {
    if (time.scale == "linear") {
      out <- tryCatch(

        if (TRUE %in% c(fix.y0, fix.a)) {

          if (fix.a == FALSE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPL2_fixy0(x = intervals, a, bta, k),
              data = data,
              algorithm = algorithm,
              start = list(a = starta, bta = startbta, k = startk),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == FALSE) {

            gsl_nls(
              gp ~ FourPL2_fixa(x = intervals, a = max(gp), bta, k, y0),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, k = startk, y0 = starty0),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPL2_fixa_fixy0(x = intervals, a = max(gp),
                                      bta, k),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, k = startk),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))
          }

        } else {

          gsl_nls(
            gp ~ FourPL2(x = intervals, a, bta, k, y0),
            data = data,
            algorithm = algorithm,
            start = list(a = starta, bta = startbta,
                         k = startk, y0 = starty0),
            control = list(maxiter = maxiter, warnOnly = warnOnly,
                           scale = "levenberg"))

        },

        error = function(e) e)
    }

    if (time.scale == "log") {
      out <- tryCatch(

        if (TRUE %in% c(fix.y0, fix.a)) {

          if (fix.a == FALSE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPLL2_fixy0(x = intervals, a, bta, k),
              data = data,
              algorithm = algorithm,
              start = list(a = starta, bta = startbta, k = startk),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == FALSE) {

            gsl_nls(
              gp ~ FourPLL2_fixa(x = intervals, a = max(gp), bta, k, y0),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, k = startk, y0 = starty0),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))

          }

          if (fix.a == TRUE & fix.y0 == TRUE) {

            gsl_nls(
              gp ~ FourPLL2_fixa_fixy0(x = intervals, a = max(gp),
                                       bta, k),
              data = data,
              algorithm = algorithm,
              start = list(bta = startbta, k = startk),
              control = list(maxiter = maxiter, warnOnly = warnOnly,
                             scale = "levenberg"))
          }

        } else {

          gsl_nls(
            gp ~ FourPLL2(x = intervals, a, bta, k, y0),
            data = data,
            algorithm = algorithm,
            start = list(a = starta, bta = startbta,
                         k = startk, y0 = starty0),
            control = list(maxiter = maxiter, warnOnly = warnOnly,
                           scale = "levenberg"))

        },

        error = function(e) e)
    }
  }

  return(out)

}
