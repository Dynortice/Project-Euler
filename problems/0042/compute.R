source("euler/R/calculus.R")

compute <- function(path) {
    triangles <- triangular_numbers(20)
    triangle_words <- 0
    for (name in strsplit(gsub("\"", "", readLines(path, warn = FALSE)), ",")[[1]]) {
        if (any(sum(utf8ToInt(name) - utf8ToInt("A") + 1) == triangles)) triangle_words <- triangle_words + 1
    }
    return(triangle_words)
}
