compute <- function(string) {
    string <- sort(strsplit(gsub("\"", "", string), ",")[[1]])
    n <- length(string)
    i <- 1; result <- 0
    while (i <= n) {
        result <- result + i * sum(utf8ToInt(string[i]) - utf8ToInt("A") + 1)
        i <- i + 1
    }
    return(result)
}
