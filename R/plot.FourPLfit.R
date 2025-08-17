
#' Plot the four-parameter logistic or log-logistic function fitted to
#' germination count data from a \code{FourPLfit} object
#'
#' @param x An object of class \code{FourPLfit} obtained as output from the
#'   \code{\link[dormancymetrics]{FourPLfit}} function.
#' @param rdr If \code{TRUE}, plots the Rate of Dormancy Release curve (RDR).
#'   Default is \code{TRUE}.
#' @param DSDS50 If \code{TRUE}, highlights the days of seed dry storage
#'   required to reach 50\% germination. Default is \code{TRUE}.
#' @param limits logical. If \code{TRUE}, set the limits of y axis (germination
#'   percentage) between 0 and 100 in the germination curve plot. If
#'   \code{FALSE}, limits are set according to the data. Default is \code{TRUE}.
#' @param plotlabels logical. If \code{TRUE}, adds labels to the germination
#'   curve plot. Default is \code{TRUE}.
#' @param x.axis.scale The x axis scale in log-logistic fits. Either
#'   \code{"linear"} or \code{"log"}.
#' @param \dots Default plot arguments.
#'
#' @returns The plot of the dormancy release curve as an object of class
#'   \code{ggplot}.
#'
#' @seealso \code{\link[dormancymetrics]{FourPLfit}}
#'
#' @import ggplot2
#' @import ggrepel
#' @importFrom scales label_math log_breaks log_trans
#' @method plot FourPLfit
#' @export
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
#' fitL1 <- FourPLfit(germ.counts = x, intervals = int, rep = rep,
#'                    total.seeds = 50, fix.y0 = TRUE, fix.a = TRUE,
#'                    inflection.point = "explicit", time.scale = "linear")
#'
#' fitL2 <- FourPLfit(germ.counts = x, intervals = int, rep = rep,
#'                    total.seeds = 50, fix.y0 = TRUE, fix.a = TRUE,
#'                    inflection.point = "implicit", time.scale = "linear")
#'
#' plot(fitL1)
#' plot(fitL2)
#'
#' # Log-logistic fit
#' #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' fitLL1 <- FourPLfit(germ.counts = y, intervals = int, rep = rep,
#'                     total.seeds = 50, fix.y0 = TRUE, fix.a = TRUE,
#'                     inflection.point = "explicit", time.scale = "log")
#'
#' fitLL2 <- FourPLfit(germ.counts = y, intervals = int, rep = rep,
#'                     total.seeds = 50, fix.y0 = TRUE, fix.a = TRUE,
#'                     inflection.point = "implicit", time.scale = "log")
#'
#' plot(fitLL1)
#' plot(fitLL2)
#'

plot.FourPLfit <- function(x, rdr = TRUE,
                           DSDS50 = TRUE,
                           limits = TRUE, plotlabels = TRUE,
                           x.axis.scale = c("linear", "log"), ...) {

  df <- x$data
  a <- x$a
  b <- x$b
  c <- x$c
  k <- x$k
  y0 <- x$y0
  TMRDR <- x$TMRDR

  time.scale <- attributes(x)$time.scale
  inflection.point <- attributes(x)$inflection.point

  if (time.scale == "linear") {
    x.axis.scale <- "linear"
  }
  x.axis.scale <- match.arg(x.axis.scale)

  # labels positions
  if (limits == TRUE) {
    ypos <-  5
  } else {
    ypos <-  plyr::round_any(max(df$gp), 10, floor)
  }

  if (max(df$gp) == 0) {
    Gplot <- ggplot(data = df, aes(x = intervals, y = gp)) +
      geom_point(alpha = 0.5) +
      labs(x = "Time", y = "Germination (%)") +
      theme_bw()
  } else {

    # curves + DSDS50 + TMRDR
    # Plot points + FPHF fit curve

    if (time.scale == "linear") {
      if (inflection.point == "explicit") {
        Gplot <- ggplot(data = df, aes(x = intervals, y = gp)) +
          geom_point(alpha = 0.5) +
          stat_function(fun = FourPL1, colour = "red2",
                        args = list(a = a, bta = log(b, base = exp(1)),
                                    c = c, y0 = y0)) +
          labs(x = "Time", y = "Germination (%)") +
          theme_bw()
      }
      if (inflection.point == "implicit") {
        Gplot <- ggplot(data = df, aes(x = intervals, y = gp)) +
          geom_point(alpha = 0.5) +
          stat_function(fun = FourPL2, colour = "red2",
                        args = list(a = a, bta = log(b, base = exp(1)),
                                    k = k, y0 = y0)) +
          labs(x = "Time", y = "Germination (%)") +
          theme_bw()
      }
    }
    if (time.scale == "log") {
      if (inflection.point == "explicit") {
        Gplot <- ggplot(data = df, aes(x = intervals, y = gp)) +
          geom_point(alpha = 0.5) +
          stat_function(fun = FourPLL1, colour = "red2",
                        args = list(a = a, bta = log(b, base = exp(1)),
                                    c = c, y0 = y0)) +
          labs(x = "Time", y = "Germination (%)") +
          theme_bw()
      }
      if (inflection.point == "implicit") {
        Gplot <- ggplot(data = df, aes(x = intervals, y = gp)) +
          geom_point(alpha = 0.5) +
          stat_function(fun = FourPLL2, colour = "red2",
                        args = list(a = a, bta = log(b, base = exp(1)),
                                    k = k, y0 = y0)) +
          labs(x = "Time", y = "Germination (%)") +
          theme_bw()
      }
    }

    # Plot RDR curve
    if (rdr == TRUE) {

      # Get scale transformation factors
      range_fgp <- range(df$gp)

      if (time.scale == "linear") {
        if (inflection.point == "explicit") {
          range_dfgp <- range(FourPL1_deriv(x = int, y0 = y0, a = a,
                                            b = b, c = c), na.rm = TRUE)
        }
        if (inflection.point == "implicit") {
          range_dfgp <- range(FourPL2_deriv(x = int, y0 = y0, a = a,
                                            b = b, k = k), na.rm = TRUE)
        }
      }
      if (time.scale == "log") {
        if (inflection.point == "explicit") {
          range_dfgp <- range(FourPLL1_deriv(x = int, y0 = y0, a = a,
                                             b = b, c = c), na.rm = TRUE)
        }
        if (inflection.point == "implicit") {
          range_dfgp <- range(FourPLL2_deriv(x = int, y0 = y0, a = a,
                                             b = b, k = k), na.rm = TRUE)
        }
      }

      scale_factor <- diff(range_fgp) / diff(range_dfgp)
      shift <- range_fgp[1] - scale_factor * range_dfgp[1]

      # Scaled first derivative function
      if (time.scale == "linear") {
        if (inflection.point == "explicit") {
          FourPL_deriv_scaled <- function(x, y0, a, b, kc) {
            FourPL1_deriv(x, y0, a, b, c = kc) * scale_factor + shift
          }
          FourPL_args <- list(y0 = y0, a = a, b = b, kc = c)
        }
        if (inflection.point == "implicit") {
          FourPL_deriv_scaled <- function(x, y0, a, b, kc) {
            FourPL2_deriv(x, y0, a, b, k = kc) * scale_factor + shift
          }
          FourPL_args <- list(y0 = y0, a = a, b = b, kc = k)
        }
      }
      if (time.scale == "log") {
        if (inflection.point == "explicit") {
          FourPL_deriv_scaled <- function(x, y0, a, b, kc) {
            FourPLL1_deriv(x, y0, a, b, c = kc) * scale_factor + shift
          }
          FourPL_args <- list(y0 = y0, a = a, b = b, kc = c)
        }
        if (inflection.point == "implicit") {
          FourPL_deriv_scaled <- function(x, y0, a, b, kc) {
            FourPLL2_deriv(x, y0, a, b, k = kc) * scale_factor + shift
          }
          FourPL_args <- list(y0 = y0, a = a, b = b, kc = k)
        }
      }

      Gplot <- Gplot +
        stat_function(fun = FourPL_deriv_scaled,
                      colour = "royalblue4",
                      args = FourPL_args) +
        scale_y_continuous(sec.axis = sec_axis(transform = ~ (. - shift) /
                                                 scale_factor,
                                               name = "RDR"))
    }

    # TMRDR is the same as c

    # Log scale
    if (time.scale == "log") {
      if (x.axis.scale == "log") {
        Gplot <- Gplot +
          scale_x_continuous(transform = scales::log_trans(),
                             breaks = scales::log_breaks(base = exp(1)),
                             labels = scales::label_math(e^.x, format = log))
      }
    }

    # Plot DSDS50
    if (DSDS50 == TRUE) {
      xintercept <- ifelse(is.na(c), TMRDR, c)
      xintercept <- ifelse(time.scale == "log" &
                             x.axis.scale == "log",
                           log(xintercept), xintercept)
      Gplot <- Gplot +
        geom_segment(x = -Inf, xend = xintercept,
                     y = 50, yend = 50, colour = "royalblue4",
                     linetype = "dashed") +
        geom_segment(x = xintercept, xend = xintercept,
                     y = -Inf, yend = 50, colour = "royalblue4",
                     linetype = "dashed")
    }

    if (plotlabels == TRUE) {

      clab <- ifelse(time.scale == "log", "FourPLL~curve", "FourPL~curve")
      labdf <- data.frame(rbind(c(x = max(df$intervals), y = max(df$gp),
                                  lab = clab, col = "red2")),
                          stringsAsFactors = F)

      if (rdr == TRUE) {
        kc <- ifelse(is.na(c), k, c)
        kc <- ifelse(is.na(k), c, k)

        labdf <- rbind(labdf, c(x = max(df$intervals),
                                y = FourPL_deriv_scaled(x = max(df$intervals),
                                                        y0 = y0, a = a,
                                                        b = b, kc = kc),
                                lab = "RDR~curve", col = "royalblue4"))
      }

      if (DSDS50 == TRUE) {
        labdf <- rbind(labdf, c(x = ifelse(time.scale == "log" &
                                             x.axis.scale == "log",
                                           exp(xintercept), xintercept),
                                y = ypos,
                                lab = "DSDS[50]", col = "royalblue4"))
      }

      labdf$x <- as.numeric(as.character(as.factor((labdf$x))))
      labdf$y <- as.numeric(as.character(as.factor((labdf$y))))

      Gplot <- Gplot +
        geom_label_repel(data = labdf, aes(x, y, label = lab), size = 3,
                         nudge_x = 0, nudge_y = 0, colour = labdf$col,
                         na.rm = TRUE, parse = TRUE)
    }

  }

  Gplot <- Gplot +
    theme(axis.text = element_text(colour = "black"))

  return(Gplot)

}
