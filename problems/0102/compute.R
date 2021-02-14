compute <- function(path) {
    get_area <- function(ax, ay, bx, by, cx, cy) {
        return(abs((ax - cx) * (by - ay) - (ax - bx) * (cy - ay)) / 2)
    }
    triangles <- lapply(strsplit(readLines(path, warn = FALSE), ","), as.integer)
    x <- c(0, 0)
    result <- 0
    for (triangle in triangles) {
        a_ <- triangle[1:2]
        b_ <- triangle[3:4]
        c_ <- triangle[5:6]
        if (do.call(get_area, as.list(triangle)) == sum(do.call(get_area, as.list(c(a_, b_, x))),
                                                        do.call(get_area, as.list(c(a_, x, c_))),
                                                        do.call(get_area, as.list(c(x, b_, c_))))) {
            result <- result + 1
        }
    }
    return(result)
}
