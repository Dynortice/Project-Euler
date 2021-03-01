library(arrangements)

compute <- function(n, m) {
    factorials <- factorial(0:9)
    chains <- 1
    result <- 0
    combs <- combinations(9:0, n, replace = TRUE)
    for (i in seq_len(nrow(combs) - 1)) {
        combination <- combs[i,]
        for (j in seq_len(sum(combination == 0) + 1)) {
            number <- as.integer(paste0(combination, collapse = ""))
            if (is.na(chains[number])) {
                chain <- number
                term <- sum(factorials[as.integer(intToUtf8(utf8ToInt(as.character(number)), multiple = TRUE)) + 1])
                while (!any(chain == term)) {
                    chain <- c(chain, term)
                    if (!is.na(chains[term])) break
                    term <- sum(factorials[as.integer(intToUtf8(utf8ToInt(as.character(term)), multiple = TRUE)) + 1])
                }
                index <- which(chain == term)
                loop_len <- ifelse(!is.na(chains[term]), chains[term], length(chain) - index + 1)
                for (i in seq_along(chain)) if (i >= index) chains[chain[i]] <- loop_len else chains[chain[i]] <- index - i + loop_len
            }
            if (chains[number] == m) {
                digits <- length(combination)
                result <- result + (digits - sum(combination == 0)) * factorials[digits] / prod(factorials[table(combination) + 1])
            }
            if (any(combination == 0)) combination <- combination[-match(0, combination)]
        }
    }
    return(result)
}
