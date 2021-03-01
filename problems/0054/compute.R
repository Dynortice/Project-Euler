compute <- function(path) {
    is.flush <- function(suits) length(unique(suits)) == 1
    is.royal <- function(values) sum(values) == 50
    is.consecutive <- function(values, hand_value) sum(values) == 5 * (hand_value - 2)
    get_rank <- function(cards) {
        values <- unlist(card_ranks[substr(cards, 1, 1)]); suits <- substr(cards, 2, 2)
        counted_values <- table(values); unique_values <- length(counted_values); hand_value <- max(values)
        if (unique_values == 5) {
            if (is.flush(suits)) {
                if (is.consecutive(values, hand_value)) {
                    if (is.royal(values)) rank <- "Royal Flush" else rank <- "Straight Flush"
                } else {
                    rank <- "Flush"
                }
            } else if (is.consecutive(values, hand_value)) {
                rank <- "Straight"
            } else {
                rank <- "High Card"
            }
            rank_value <- hand_value
        } else {
            if (unique_values == 4) {
                rank <- "One Pair"
            } else if (unique_values == 3) {
                if (max(counted_values) == 3) rank <- "Three of a Kind" else rank <- "Two Pairs"
            } else {
                if (max(counted_values) == 4) rank <- "Four of a Kind" else rank <- "Full House"
            }
            rank_value <- as.integer(names(counted_values)[max(which(counted_values == max(counted_values)))])
        }
        return(list(rank, c(rank_value, hand_value)))
    }
    is.winner <- function(hands) {
        player_1 <- get_rank(hands[1:5]); player_2 <- get_rank(hands[6:10])
        if (hand_ranks[[player_1[[1]]]] > hand_ranks[[player_2[[1]]]]) {
            return(TRUE)
        } else if (hand_ranks[[player_1[[1]]]] == hand_ranks[[player_2[[1]]]]) {
            if (player_1[[2]][1] > player_2[[2]][1]) {
                return(TRUE)
            } else if (player_1[[2]][1] == player_2[[2]][1]) {
                if (player_1[[2]][2] > player_2[[2]][2]) return(TRUE)
            }
        }
        return(FALSE)
    }
    hand_ranks <- list("High Card" = 0, "One Pair" = 1, "Two Pairs" = 2, "Three of a Kind" = 3, "Straight" = 4,
                       "Flush" = 5, "Full House" = 6, "Four of a Kind" = 7, "Straight Flush" = 8, "Royal Flush" = 9)
    card_ranks <- list("2" = 0, "3" = 1, "4" = 2, "5" = 3, "6" = 4, "7" = 5, "8" = 6, "9" = 7, "T" = 8, "J" = 9,
                       "Q" = 10, "K" = 11, "A" = 12)
    result <- 0
    for (game in strsplit(readLines(path, warn = FALSE), " ")) {
        if (is.winner(game)) {
            result <- result + 1
        }
    }
    return(result)
}
