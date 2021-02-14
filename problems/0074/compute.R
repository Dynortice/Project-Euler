library(arrangements)

compute <- function(n, m) {
    get_next_term <- function(k) {
        return(sum(factorials[as.integer(strsplit(as.character(k), "")[[1]]) + 1]))
    }
    get_chain_len <- function(k) {
        if (!(is.na(chains[k]))) {
            return(chains[k])
        }
        term <- k
        chain <- term
        term <- get_next_term(term)
        while (!any(chain == term)) {
            chain <- c(chain, term)
            if (!is.na(chains[term])) {
                break
            }
            term <- get_next_term(term)
        }
        index_term <- which(chain == term)
        loop_len <- ifelse(!is.na(chains[term]), chains[term], length(chain) - index_term + 1)
        for (i in seq_along(chain)) {
            if (i >= index_term) {
                chains[chain[i]] <<- loop_len
            } else {
                chains[chain[i]] <<- index_term - i + loop_len
            }
        }
        return(chains[k])
    }
    factorials <- factorial(0:9)
    chains <- 1
    result <- 0
    combs <- combinations(9:0, n, replace = TRUE)
    for (i in seq_len(nrow(combs) - 1)) {
        combination <- combs[i, ]
        for (j in seq_len(sum(combination == 0) + 1)) {
            if (get_chain_len(as.integer(paste0(combination, collapse = ""))) == m) {
                n_digits <- length(combination)
                n_zeros <- sum(combination == 0)
                counter <- table(combination)
                result <- result + (n_digits - n_zeros) * factorials[n_digits] / prod(factorials[counter + 1])
            }
            if (any(combination == 0)) {
                combination <- combination[-match(0, combination)]
            }
        }
    }
    return(result)
}
