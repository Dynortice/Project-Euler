compute <- function(path, n) {
    text <- as.integer(strsplit(gsub("\"", "", readLines(path, warn = FALSE)), ",")[[1]])
    keys <- rep(list(NULL), n)
    letters <- utf8ToInt(paste0(letters, collapse = ""))
    for (i in seq_len(n)) {
        for (j in letters) {
            for (k in seq(i, length(text), n)) {
                keys[[i]] <- unique(c(keys[[i]], j))
                xor <- bitwXor(text[k], j)
                if (!(xor >= 32 && xor <= 122)) {
                    keys[[i]] <- keys[[i]][keys[[i]] != j]
                    break
                }
            }
        }
    }
    keys_prod <- as.matrix(expand.grid(keys))
    for (i in seq_len(nrow(keys_prod))) {
        decrypted_text <- ""
        result <- 0
        for (j in seq_along(text)) {
            xor <- bitwXor(text[j], keys_prod[i, (j - 1) %% n + 1])
            decrypted_text <- paste0(decrypted_text, intToUtf8(xor))
            result <- result + xor
        }
        if (grepl(" the ", decrypted_text)) return(result)
    }
}