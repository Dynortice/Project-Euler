using StatsBase: countmap
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(path::String)::Int
    is_flush(suits::Vector{Char})::Bool = length(Set(suits)) == 1
    is_royal(c_values::Vector{Int})::Bool = sum(c_values) == 55
    is_consecutive(c_values::Vector{Int}, hand_value::Int)::Bool = sum(c_values) == (5 * (hand_value - 2))
    get_rank_value(counted_values::Dict{Int, Int})::Int = maximum(value for (value, kinds) ∈ counted_values if kinds == maximum(collect(values(counted_values))))

    function get_rank(cards::Vector{SubString{String}})::Tuple{String, Int, Int}
        c_values, suits = map(x -> card_ranks[x], getindex.(cards, 1)), getindex.(cards, 2)
        counted_values, hand_value = countmap(c_values), maximum(c_values)
        unique_values = length(counted_values)
        if unique_values == 5
            if is_flush(suits)
                if is_consecutive(c_values, hand_value)
                    if is_royal(c_values)
                        rank = "Royal Flush"
                    else
                        rank = "Straight Flush"
                    end
                else
                    rank = "Flush"
                end
            elseif is_consecutive(c_values, hand_value)
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

    function is_winner(hands::Vector{SubString{String}})::Bool
        player_1, player_2 = map(get_rank, [hands[1:5], hands[6:end]])
        if hand_ranks[player_1[1]] > hand_ranks[player_2[1]]
            return true
        elseif hand_ranks[player_1[1]] == hand_ranks[player_2[1]]
            if player_1[2] > player_2[2]
                return true
            elseif player_1[2] == player_2[2]
                return player_1[3] > player_2[3]
            end
        end
        return false
    end

    hand_ranks = Dict(hand => rank for (rank, hand) ∈ enumerate(["High Card", "One Pair",
                                                                 "Two Pairs", "Three of a Kind",
                                                                 "Straight", "Flush", "Full House",
                                                                 "Four of a Kind", "Straight Flush",
                                                                 "Royal Flush"]))
    card_ranks = Dict(card => rank for (rank, card) ∈ enumerate(['2', '3', '4', '5', '6', '7', '8',
                                                                 '9', 'T', 'J', 'Q', 'K', 'A']))
    return sum(map(x -> is_winner(split(x, " ")), split(read(path, String), "\n")))
end

compute("problems/0054/p054_poker.txt")

@benchmark compute("problems/0054/p054_poker.txt")