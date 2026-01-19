#' Four parameter logistic (with explicit inflection point)
#'
#' To be used by
#' \code{\link[dormancymetrics]{FourPLfit}}. \loadmathjax
#'
#' @param x The explanatory/independent variable value.
#' @param a Parameter \mjseqn{a}.
#' @param bta Parameter \mjseqn{\beta} where \mjseqn{b = e^{\beta}}.
#' @param b Parameter \mjseqn{b}.
#' @param c Parameter \mjseqn{c}.
#' @param y0 Parameter \mjseqn{y_{0}}.
#'
#' @return The calculated response/dependent value.
#'
#' @export
#'
FourPL1 <- function(x, a, bta, c, y0) {
  y0 + ((a - y0) /
          (1 + exp(-exp(bta) * (x - c)))) # b = -exp(bta) to enforce +ive slope
}

#' @rdname FourPL1
#' @export
# 4PL (explicit c) with a fixed to max(gp)
FourPL1_fixa <- function(x, a = 100, bta, c, y0) {
  y0 + ((a - y0) /
          (1 + exp(-exp(bta) * (x - c))))
}

#' @rdname FourPL1
#' @export
# 4PL (explicit c) with y0 fixed to 0
FourPL1_fixy0 <- function(x, a, bta, c) {
  0 + ((a - 0) /
         (1 + exp(-exp(bta) * (x - c))))
}

#' @rdname FourPL1
#' @export
# 4PL (explicit c) with a fixed to max(gp) & y0 fixed to 0
FourPL1_fixa_fixy0 <- function(x, a = 100, bta, c) {
  0 + ((a - 0) /
         (1 + exp(-exp(bta) * (x - c))))
}

#' @rdname FourPL1
#' @export
# Rate of dormancy release function - partial derivative of 4PL1
FourPL1_deriv <- function(x, y0, a, b, c) {
  exp_term <- exp(-b * (x - c))
  numerator <- (a - y0) * b * exp_term
  denominator <- (1 + exp_term) ^ 2
  dy_dt <- numerator / denominator
  return(dy_dt)
}

#' Four paramter logistic (with implicit inflection point)
#'
#' To be used by
#' \code{\link[dormancymetrics]{FourPLfit}}. \loadmathjax
#'
#' @param x The explanatory/independent variable value.
#' @param a Parameter \mjseqn{a}.
#' @param bta Parameter \mjseqn{\beta} where \mjseqn{b = e^{\beta}}.
#' @param b Parameter \mjseqn{b}.
#' @param k Parameter \mjseqn{k}.
#' @param y0 Parameter \mjseqn{y_{0}}.
#'
#' @return The calculated response/dependent value value.
#'
#' @export
#'
FourPL2 <- function(x, a, bta, k, y0) {
  y0 + ((a - y0) /
          (1 + k * exp(-exp(bta) * x))) # b = -exp(bta) to enforce +ive slope
}

#' @rdname FourPL2
#' @export
# 4PL (implicit c) with a fixed to max(gp)
FourPL2_fixa <- function(x, a = 100, bta, k, y0) {
  y0 + ((a - y0) /
          (1 + k * exp(-exp(bta) * x)))
}

#' @rdname FourPL2
#' @export
# 4PL (implicit c) with y0 fixed to 0
FourPL2_fixy0 <- function(x, a, bta, k) {
  0 + ((a - 0) /
         (1 + k * exp(-exp(bta) * x)))
}

#' @rdname FourPL2
#' @export
# 4PL (implicit c) with a fixed to max(gp) & y0 fixed to 0
FourPL2_fixa_fixy0 <- function(x, a = 100, bta, k) {
  0 + ((a - 0) /
         (1 + k * exp(-exp(bta) * x)))
}

#' @rdname FourPL2
#' @export
# Rate of dormancy release function - partial derivative of 4PL2
FourPL2_deriv <- function(x, y0, a, b, k) {
  L <- a - y0
  exp_term <- exp(-b * x)
  numerator <- L * b * k * exp_term
  denominator <- (1 + k * exp_term)^2
  dy_dt <- numerator / denominator
  return(dy_dt)
}
