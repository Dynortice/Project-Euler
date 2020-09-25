compute <- function(text, key_len) {
    is.letter <- function(a, b) {
        xor_ <- bitwXor(a, b)
        if ((xor_ >= 32) & (xor_ <= 122)) {
            return(TRUE)
        } else {
            return(FALSE)
        }
    }

    keys <- rep(list(NULL), key_len)
    letters_ <- utf8ToInt(paste0(letters, collapse = ""))
    for (i in seq_len(key_len)) {
        for (j in letters_) {
            for (k in seq(i, length(text), key_len)) {
                keys[[i]] <- unique(c(keys[[i]], j))
                if (!is.letter(j, text[k])) {
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
            xor_ <- bitwXor(text[j], keys_prod[i, (j - 1) %% key_len + 1])
            decrypted_text <- paste0(decrypted_text, intToUtf8(xor_))
            result <- result + xor_
        }
        if (grepl(" the ", decrypted_text)) {
            return(result)
        }
    }
}