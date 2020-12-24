using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

RANKS = ["High Card", "One Pair", "Two Pairs", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush", "Royal Flush"]
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
HAND_RANKS = Dict(hand => rank for (rank, hand) ∈ enumerate(RANKS))
CARD_RANKS = Dict(card => rank for (rank, card) ∈ enumerate(CARDS))

function compute(path::String)::Int64
    is_flush(suits::Array{Char,1})::Bool = length(Set(suits)) == 1
    is_royal(values_::Array{Int64, 1})::Bool = sum(values_) == 55
    is_consecutive(values_::Array{Int64, 1}, hand_value::Int64)::Bool = sum(values_) == (5 * (hand_value - 2))

    function get_rank_value(counted_values::Dict{Int64, Int64})::Int64
        max_kinds = maximum(collect(values(counted_values)))
        return maximum(value for (value, kinds) in counted_values if kinds == max_kinds)
    end

    function get_rank(cards::Array{SubString{String}, 1})::Tuple{String, Int64, Int64}
        values_ = map(x -> CARD_RANKS[x], getindex.(cards, 1))
        suits = getindex.(cards, 2)
        counted_values = Dict(i => count(j -> i == j, values_) for i ∈ Set(values_))
        unique_values = length(counted_values)
        hand_value = maximum(values_)
        if unique_values == 5
            if is_flush(suits)
                if is_consecutive(values_, hand_value)
                    if is_royal(values_)
                        rank = "Royal Flush"
                    else
                        rank = "Straight Flush"
                    end
                else
                    rank = "Flush"
                end
            elseif is_consecutive(values_, hand_value)
                rank = "Straight"
            else
                rank = "High Card"
            end
            rank_value = hand_value
        else
            if unique_values == 4
                rank = "One Pair"
            elseif unique_values == 3
                if maximum(collect(values(counted_values))) == 3
                    rank = "Three of a Kind"
                else
                    rank = "Two Pairs"
                end
            else
                if maximum(collect(values(counted_values))) == 4
                    rank = "Four of a Kind"
                else
                    rank = "Full House"
                end
            end
            rank_value = get_rank_value(counted_values)
        end
        return rank, rank_value, hand_value
    end

    function is_winner(hands::Array{SubString{String}, 1})::Bool
        player_1, player_2 = get_rank(hands[1:5]), get_rank(hands[6:end])
        if HAND_RANKS[player_1[1]] > HAND_RANKS[player_2[1]]
            return true
        elseif HAND_RANKS[player_1[1]] == HAND_RANKS[player_2[1]]
            if player_1[2] > player_2[2]
                return true
            elseif player_1[2] == player_2[2]
                return player_1[3] > player_2[3]
            end
        end
        return false
    end
    return sum(map(x -> is_winner(split(x, " ")), split(read(path, String), "\n")))
end

compute("problems/0054/p054_poker.txt")

@benchmark compute("problems/0054/p054_poker.txt")