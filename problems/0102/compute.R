source("euler/R/geometry.R")

compute <- function(path) {
    triangles <- lapply(strsplit(readLines(path, warn = FALSE), ","), as.integer)
    x <- c(0, 0)
    result <- 0
    for (triangle in triangles) {
        a <- triangle[1:2]; b <- triangle[3:4]; c <- triangle[5:6]
        if (triangle_area(a, b, x) + triangle_area(a, x, c) + triangle_area(x, b, c) == triangle_area(a, b, c)) result <- result + 1
    }
    return(result)
}
