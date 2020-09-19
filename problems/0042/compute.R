compute <- function(string) {
    triangles <- 1L

    add_triangle <- function() {
        n <- length(triangles)
        triangles <<- c(triangles, n * (n + 1) / 2)
    }

    triangle_words <- 0

    for (name in string) {
        value <- sum(utf8ToInt(name) - utf8ToInt("A") + 1)
        while (value > max(triangles)) {
            add_triangle()
        }
        if (value %in% triangles) {
            triangle_words <- triangle_words + 1
        }
    }
    return(triangle_words)
}
