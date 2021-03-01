#' Get max between two numbers
#'
#' @param a: Number
#' @param b: Number
#' @examples:
#' fast_max(100, 50)
#' fast_max(as.bigint(48), as.bigint(49))
fast_max <- function(a, b) if (a > b) a else b

#' Get min between two numbers
#'
#' @param a: Number
#' @param b: Number
#' @examples:
#' fast_min(100, 50)
#' fast_min(as.bigint(48), as.bigint(49))
fast_min <- function(a, b) if (a < b) a else b
