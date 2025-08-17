
#' Fit four-parameter logistic or log-logistic function
#'
#' Fit a four-parameter logistic or log-logistic function
#' \insertCite{bentsink_natural_2010,bentsink_identification_2011,postma_maternal_2015,fogliatto_effect_2020}{dormancymetrics}
#' to germination count data recorded at sequential time intervals of seed
#' storage to model a dormancy release curve and compute the associated
#' parameters. \loadmathjax
#'
#' The germination count data of a seed lot recorded at sequential time
#' intervals of storage can be modelled to fit a \strong{four-parameter
#' logistic} function defined as follows
#' \insertCite{bentsink_natural_2010,bentsink_identification_2011}{dormancymetrics}.
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + e^{-b(x - c)}}}
#'
#' Where, \mjseqn{y} is the germination percentage at the \mjseqn{x} time
#' interval after storage, \mjseqn{y_{0}} is the lower asymptote, or intercept
#' on the y axis, \mjseqn{a} is the upper asymptote, or maximum germination
#' percentage, \mjseqn{b} is a mathematical parameter controlling the shape and
#' steepness of the dormancy release curve (the larger the \mjseqn{b} parameter,
#' the steeper the rise toward the asymptote \mjseqn{a}, and the shorter the
#' time between initial germination value and maximum germination), and
#' \mjseqn{c} is the inflection point which represents the time point of storage
#' with maximum rate of dormancy release. \mjseqn{c} is the \mjseqn{DSDS_{50}}
#' (days of seed dry storage required to reach 50\% germination).
#'
#' This model has the inflection point \mjseqn{c} explicitly included.
#' Alternatively the data can also be modelled to fit a four-parameter logistic
#' function with implicit inflection point
#' \insertCite{postma_maternal_2015}{dormancymetrics} defined as follows.
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + k \cdot e^{-b \cdot x}}}
#'
#' Where, \mjseqn{k} controls the initial value of the function at \mjseqn{x =
#' 0}. It determines the initial steepness and starting value of the curve. It
#' is the asymmetry or horizontal shift factor which affects where the curve
#' reaches its inflection point and introduces asymmetry.
#'
#' \mjsdeqn{k = e^{bc} \; \textrm{and} \; c = \frac{\ln{k}}{b}}
#'
#' This is useful in cases where more than 50\% germination is achieved in the
#' first time interval itself.
#'
#' This model is more suitable where the dormancy release over a linear time
#' scale is smooth and symmetrical. In cases of rapid early dormancy release
#' with a long tail of the curve, a \strong{log-logistic model} is more
#' appropriate \insertCite{fogliatto_effect_2020}{dormancymetrics}. Here the
#' time \mjseqn{x} is scaled logarithmically.
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + e^{-b(\log(x) - \log(c))}}}
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + k \cdot x^{b}} \; \left (\textrm{As} \;
#' e^{b \cdot \log(x)} = x^{b}  \right )}
#'
#' In \code{FourPLfit}, these models have been reparameterized by substituting
#' \mjseqn{b} with \mjseqn{e^{\beta}} to constraint \mjseqn{b} to positive
#' values only.
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + e^{-e^{\beta}(x - c)}}}
#'
#' \mjsdeqn{y(x) = y_0 + \frac{a - y_{0}}{1 + k \cdot e^{-e^{\beta} \cdot x}}}
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + e^{-e^{\beta}(\log(x) -
#' \log(c))}}}
#'
#' \mjsdeqn{y(x) =  y_{0} + \frac{a - y_{0}}{1 + k \cdot x^{e^{\beta}}}}
#'
#' @param germ.counts Germination counts at each time interval (days of seed
#'   storage) as a numeric vector.
#' @param intervals Time intervals of seed storage as a numeric vector.
#' @param rep Optional. An integer vector indicating the replication
#'   corresponding to each germination count.
#' @param total.seeds Total number of seeds as an integer vector of unit length.
#' @param fix.y0 Force the intercept of the y axis through 0.
#' @param fix.a Fix a as the actual maximum germination percentage at the end of
#'   the experiment.
#' @param inflection.point Either \code{"explicit"} or \code{"implicit"}. See
#'   \strong{Details}.
#' @param time.scale Either \code{"linear"} for fitting a four-parameter
#'   logistic function or \code{"logarithmic"} for fitting a four-parameter
#'   log-logistic function.
#' @param tmax The time interval up to which AUC is to be computed.
#' @param tries The number of tries to be attempted to fit the curve. Default is
#'   3.
#'
#' @returns A list with the following components: \item{data}{A data frame with
#'   the data used for computing the model.} \item{Parameters}{A data frame of
#'   parameter estimates, standard errors and p value.}  \item{Fit}{A one-row
#'   data frame with estimates of model fitness such as log likelyhoods, Akaike
#'   Information Criterion, Bayesian Information Criterion, deviance and
#'   residual degrees of freedom.}  \item{a}{The upper asymptote, or maximum
#'   germination percentage.}  \item{b}{The mathematical parameter controlling
#'   the shape and steepness of the dormancy release curve.} \item{c}{The
#'   inflection point which represents the time point of storage with maximum
#'   rate of dormancy release.}  \item{y0}{The lower asymptote, or intercept on
#'   the y axis.} \item{TMRDR}{Time at maximum rate of dormancy release.}
#'   \item{AUC}{The estimate of area under the curve.} \item{msg}{The message
#'   from \code{\link[gslnls]{gsl_nls}}.} \item{isConv}{Logical value
#'   indicating whether convergence was achieved.} \item{model}{The raw fitted
#'   model output as a list of class \code{gsl_nls}.}
#'
#' @import gslnls
#' @import mathjaxr
#' @importFrom broom glance
#' @importFrom broom tidy
#' @importFrom plyr round_any
#' @importFrom stats coef df integrate lm optimize predict
#' @importFrom utils globalVariables
#' @importFrom Rdpack reprompt
#'
#' @export
#'
#' @references
#'
#' \insertAllCited{}
#'
#' @examples
#' x <- c(2, 1, 2, 2, 0, 0, 2, 2, 0, 2, 2, 0, 2, 2, 2, 6, 8, 10, 8, 19,
#'        8, 4, 11, 4, 22, 19, 25, 16, 21, 30, 40, 33, 34, 36, 44, 42,
#'        42, 39, 42, 38, 47, 42, 50, 44, 48, 50)
#' y <- c(0, 0, 14, 14, 18, 18, 20, 20, 21, 21, 22, 22, 23, 23, 23, 23,
#'        24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 26, 26, 26, 26,
#'        26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27)
#' rep <- rep(1:2, 23)
#' int <- rep(c(0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 31, 35, 39, 43, 47, 52,
#'              57, 62, 67, 72, 82, 92, 102), each = 2)
#' total.seeds = 50
#'
#' # Logistic fit
#' #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' FourPLfit(germ.counts = x, intervals = int, rep = rep, total.seeds = 50,
#'           fix.y0 = TRUE, fix.a = TRUE,
#'           inflection.point = "explicit", time.scale = "linear")
#'
#' FourPLfit(germ.counts = x, intervals = int, rep = rep, total.seeds = 50,
#'           fix.y0 = TRUE, fix.a = TRUE,
#'           inflection.point = "implicit", time.scale = "linear")
#'
#' # Log-logistic fit
#' #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' FourPLfit(germ.counts = y, intervals = int, rep = rep, total.seeds = 50,
#'           fix.y0 = TRUE, fix.a = TRUE,
#'           inflection.point = "explicit", time.scale = "log")
#'
#' FourPLfit(germ.counts = y, intervals = int, rep = rep, total.seeds = 50,
#'           fix.y0 = TRUE, fix.a = TRUE,
#'           inflection.point = "implicit", time.scale = "log")
#'
FourPLfit <- function(germ.counts, intervals, rep, total.seeds,
                      fix.y0 = TRUE, fix.a = TRUE,
                      inflection.point = c("explicit", "implicit"),
                      time.scale = c("linear", "log"),
                      tmax = max(intervals), tries = 3) {

  # Checks ----

  # Check if argument germ.counts is of type numeric
  if (!is.numeric(germ.counts)) {
    stop("'germ.counts' should be a numeric vector.")
  }

  # Check if argument intervals is of type numeric
  if (!is.numeric(intervals)) {
    stop("'intervals' should be a numeric vector.")
  }

  # Check if intervals are uniform
  idiff <- diff(unique(intervals))
  if (!all(abs(idiff - idiff[[1]]) < .Machine$double.eps ^ 0.5)) {
    warning("'intervals' are not uniform.")
  }

  # Check if germ.counts and intervals are of equal length
  if (length(germ.counts) != length(intervals)) {
    stop("'germ.counts' and 'intervals' lengths differ.")
  }

  if (!is.null(rep)) {
    # Check if germ.counts and rep are of equal length
    if (length(germ.counts) != length(rep)) {
      stop("'germ.counts' and 'rep' lengths differ.")
    }

    # Check data balance
    if (length(unique(table(intervals, rep))) != 1) {
      stop("The data is not balanced. Please check 'intervals' and 'rep'.")
    }
  }

  # Check if argument total.seeds is of type numeric with unit length
  if (!is.numeric(total.seeds) || length(total.seeds) != 1) {
    stop("'total.seeds' should be a numeric vector of length 1.")
  }

  # Check GP
  GP <- max((germ.counts / total.seeds) * 100)

  if (GP == 0) {
    warning("Final germination percentage is 0%.\n",
            "The computation is not possible.")
  } else {
    if (GP < 10) {
      warning("Final germination percentage is less than 10%.\n",
              "The computation may not be appropriate.")
    }
  }

  # Check if tmax is of type numeric with unit length
  if (!is.numeric(tmax) || length(tmax) != 1) {
    stop("'tmax' should be a numeric vector of length 1.")
  }

  # Check if tmax is > 0
  if (tmax < 0) {
    stop("'tmax' should be greater than 0.")
  }

  # Check if tries is of type numeric with unit length
  if (!is.numeric(tries) || length(tries) != 1) {
    stop("'tries' should be a numeric vector of length 1.")
  }

  # Check if tries is > 0
  if (tries < 0) {
    stop("'tries' should be greater than 0.")
  }

  inflection.point <- match.arg(inflection.point)
  time.scale <- match.arg(time.scale)

  # Prep data and output ----

  gp <- (germ.counts / total.seeds) * 100

  if (!is.null(rep)) {
    df <- data.frame(gp, rep, intervals)
  } else {
    df <- data.frame(gp, intervals)
  }

  # Blank output
  parameters <- data.frame(term = c("a", "b", "c", "k", "y0"),
                           estimate = rep(NA_integer_),
                           std.error = rep(NA_integer_, 5),
                           statistic = rep(NA_integer_, 5),
                           p.value = rep(NA_integer_, 5))

  fit <- data.frame(sigma = NA_integer_, isConv = NA, finTol = NA_integer_,
                    logLik = NA_integer_, AIC = NA_integer_, BIC = NA_integer_,
                    deviance = NA_integer_, df.residual = NA_integer_,
                    nobs = NA_integer_)

  a <- NA_integer_
  b <- NA_integer_
  c <- NA_integer_
  k <- NA_integer_
  y0 <- NA_integer_
  AUC <- NA_integer_
  isConv <- NA
  mod <- NULL

  # Starting values ----

  ## Initial starting values ----

  if (GP > 0) { # perform fit only if GP > 0

    if (time.scale == "linear") {

      starty0 <- min(gp)
      # starty0 <- 0
      starta  <- max(gp)
      gp_mid <- (starta + starty0) / 2

      if (inflection.point == "explicit") {

        # Rough Inflection point estimate
        # intervals where gp ≈ midpoint
        index_closest <- which.min(abs(intervals - gp_mid))
        startc <- intervals[index_closest]

        # Rough estimate of b
        # By linear approximation of logit
        logit_gp <- log((intervals - starty0) / (starta - gp))
        dt <- data.frame(intervals, logit_gp)
        dt <- dt[is.finite(dt$logit_gp), ]
        if (nrow(dt) >= 2) {
          b_model <- lm(logit_gp ~ intervals, data = dt)
        }
        startb <- coef(b_model)[2]

      }
      if (inflection.point == "implicit") {

        # Transform response gp
        epsilon <- 1e-8
        fraction <- ((starta - starty0) / (gp - starty0 + + epsilon))
        z <- log(pmax(fraction - 1, epsilon))
        dt <- data.frame(intervals, z)

        # Linear regression to estimate log(k) and startb
        if (nrow(dt) >= 2) {
          b_model <- lm(z ~ intervals, data = dt)
        }
        log_k <- coef(b_model)[1]
        startb <- -coef(b_model)[2]
        startk <- exp(log_k)

      }
    }
    if (time.scale == "log") {

      # Remove intervals = 0
      nonzero_indices <- intervals > 0
      int_nz <- intervals[nonzero_indices]
      gp_nz <- gp[nonzero_indices]

      starty0 <- min(gp_nz)
      starta <- max(gp_nz)
      gp_mid <- (starty0 + starta) / 2

      # Rough Inflection point estimate
      # intervals where gp ≈ midpoint
      index_closest <- which.min(abs(gp_nz - gp_mid))
      startc <- int_nz[index_closest]

      # Estimate b in log space
      logit_gp <- log((gp_nz - starty0) / (starta - gp_nz))
      dt <- data.frame(intervals = log(int_nz), logit_gp = logit_gp)
      dt <- dt[is.finite(dt$logit_gp), ]
      if (nrow(dt) >= 2) {
        b_model <- lm(logit_gp ~ intervals, data = dt)
      }
      startb <- coef(b_model)[2]

      # if (time.scale == "linear") {
      # }

      if (inflection.point == "implicit") {

        int_mid <- startc
        startb <- startb
        startk <- int_mid ^ startb

      }
    }

    startb <- max(abs(startb), 0.01) # Ensure positive and not too small
    startbta <- log(startb, base = exp(1))

    ## Test starting values ----

    tryStart <-
      FourPL_withWE(data = df,
                    fix.a = fix.a, fix.y0 = fix.y0,
                    starta = starta, startb = startbta,
                    startc = startc, startk = startk,
                    starty0 = starty0,
                    maxiter = 1024, inflection.point = inflection.point,
                    time.scale = time.scale)

    ### Test with grid ----


    # Fit the model - using gsl_nls ----
    ## With tries ----

    msg <- ""

    for (i in 1:tries) {
      # check if convergence possible with start values
      possibleError <-
        FourPL_withWE(data = df,
                      fix.a = fix.a, fix.y0 = fix.y0,
                      starta = starta, startb = startbta,
                      startc = startc, startk = startk,
                      starty0 = starty0,
                      maxiter = 1024, inflection.point = inflection.point,
                      time.scale = time.scale)

      if (!inherits(possibleError, "error") &&
          possibleError$convInfo$isConv == TRUE) {

        mod <- possibleError
        rm(possibleError)

        filler <- ifelse(i == 1, "#", "\n#")
        msg <- paste(msg, filler, i, ". ", mod$convInfo$stopMessage, " ",
                     sep = "")
        break # break out of loop if convergence is successful

      } else {# In case of convergence failure with initial start values

        # suppress warnings and rerun above with warnOnly = TRUE

        mod <-
          FourPL_withWE(data = df,
                        fix.a = fix.a, fix.y0 = fix.y0,
                        starta = starta, startb = startbta,
                        startc = startc, , startk = startk,
                        starty0 = starty0,
                        maxiter = 1024, warnOnly = TRUE,
                        inflection.point = inflection.point,
                        time.scale = time.scale)

        # Extract convergence msg
        if (!inherits(mod, "error")) {

          filler <- ifelse(i == 1, "#", "\n#")
          msg <- paste(msg, filler, i, ". ", mod$convInfo$stopMessage,
                       " ", sep = "")

          # Get new start values
          starta <- coef(mod)["a"]
          startbta <- coef(mod)["bta"]
          startc <- coef(mod)["c"]
          starty0 <- 0

        } else {

          filler <- ifelse(i == 1, "#", "\n#")
          msg <- paste(msg, filler, i, ". ", mod$message,
                       " ", sep = "")

          break # break out of loop if convergence is NOT successful
        }

      }
    }

    ## Solutions for specific error codes ----

    # "exceeded max number of iterations"
    if (mod$convInfo$stopCode == 11) {

    }

    # "iteration is not making progress towards solution"
    if (mod$convInfo$stopCode == 27) {
    }

    # Prepare output ----
    if (!inherits(mod, "error")) {
      isConv <-  mod$convInfo$isConv

      # Parameters estimates
      parameters <- tidy(mod)

      # Fit quality
      fit <- glance(mod)

      # Lower asymptote
      if (fix.y0) {
        y0 <- 0
      } else {
        y0 <- unname(unlist(parameters[parameters$term == "y0", "estimate"]))
      }

      # Upper asymptote
      if (fix.a) {
        a <- max(gp)
      } else {
        a <- unname(unlist(parameters[parameters$term == "a", "estimate"]))
      }

      # Slope/Shape and steepness
      bta <- unname(unlist(parameters[parameters$term == "bta", "estimate"]))
      b <- exp(bta)

      # c and k
      c <- NA
      k <- NA

      if (inflection.point == "explicit") {
        c <- unname(unlist(parameters[parameters$term == "c", "estimate"]))
      } else {
        k <- unname(unlist(parameters[parameters$term == "k", "estimate"]))
      }

      # Time at maximum rate of dormancy release
      if (time.scale == "linear") {
        if (inflection.point == "explicit") {
          t_rdr_max <- optimize(FourPL1_deriv, interval = range(intervals),
                                maximum = TRUE, y0 = y0, a = a, b = b, c = c)
        }
        if (inflection.point == "implicit") {
          t_rdr_max <- optimize(FourPL2_deriv, interval = range(intervals),
                                maximum = TRUE, y0 = y0, a = a, b = b, k = k)
        }
      }
      if (time.scale == "log") {
        if (inflection.point == "explicit") {
          t_rdr_max <- optimize(FourPLL1_deriv, interval = range(intervals),
                                maximum = TRUE, y0 = y0, a = a, b = b, c = c)
        }
        if (inflection.point == "implicit") {
          t_rdr_max <- optimize(FourPLL2_deriv, interval = range(intervals),
                                maximum = TRUE, y0 = y0, a = a, b = b, k = k)
        }
      }
      t_rdr_max <- t_rdr_max$maximum

      # Area under the curve - add argument max time
      if (time.scale == "linear") {
        if (inflection.point == "explicit") {
          AUC <- integrate(FourPL1, lower = 0, upper = tmax,
                           a = a, bta = bta, c = c, y0 = y0)$value
        }
        if (inflection.point == "implicit") {
          AUC <- integrate(FourPL2, lower = 0, upper = tmax,
                           a = a, bta = bta, k = k, y0 = y0)$value
        }
      }
      if (time.scale == "log") {
        if (inflection.point == "explicit") {
          AUC <- integrate(FourPLL1, lower = 0, upper = tmax,
                           a = a, bta = bta, c = c, y0 = y0)$value
        }
        if (inflection.point == "implicit") {
          AUC <- integrate(FourPLL2, lower = 0, upper = tmax,
                           a = a, bta = bta, k = k, y0 = y0)$value
        }
      }
    } else {
      warning("Convergence Error\n", paste(msg, collapse = "\n"))
    }

  } else {
    msg <- paste("Maximum germination percentage is 0%.",
                 "The computation is not possible.", sep = " ")
  }

  output <- list(data = df, Parameters = data.frame(parameters),
                 Fit = as.data.frame(fit),
                 a = a, b = b, c = c, k = k, y0 = y0,
                 TMRDR = t_rdr_max, AUC = AUC,
                 msg = msg, isConv = isConv, model = mod)

  # Set Class
  class(output) <- c("FourPLfit", class(output))

  attr(output, "inflection.point") <- inflection.point
  attr(output, "time.scale") <- time.scale

  return(output)
  rm(mod)

}
