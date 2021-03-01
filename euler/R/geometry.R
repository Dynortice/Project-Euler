#' Get area of triangle using coordinates of points
#'
#' @param a: Point
#' @param b: Point
#' @param c: Point
#' @returns: Area of triangle
#' @examples
#' triangle_area(c(0, 0), c(0, 3), c(4, 0))
#' triangle_area(c(-23, 11), c(19, 95), c(-12, 114))
triangle_area <- function(a, b, c) abs((a[1] - c[1]) * (b[2] - a[2]) - (a[1] - b[1]) * (c[2] - a[2])) / 2
