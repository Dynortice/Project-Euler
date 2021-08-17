from collections import Counter


def compute(path: str) -> int:
    def is_flush(suits: list[str, ...]) -> bool:
        return len(set(suits)) == 1

    def is_royal(values: list[str, ...]) -> bool:
        return sum(values) == 50

    def is_consecutive(values: list[str, ...], hand_value: int) -> bool:
        return sum(values) == 5 * (hand_value - 2)

    def get_rank_value(counted_values: Counter) -> int:
        return max(value for value, kinds in counted_values.items() if kinds == max(counted_values.values()))

    def get_rank(cards: list[str, ...]) -> (str, int, int):
        values, suits = [card_ranks[card[0]] for card in cards], [card[1] for card in cards]
        counted_values, hand_value = Counter(values), max(values)
        unique_values = len(counted_values)
        if unique_values == 5:
            if is_flush(suits):
                if is_consecutive(values, hand_value):
                    rank = 'Royal Flush' if is_royal(values) else 'Straight Flush'
                else:
                    rank = 'Flush'
            elif is_consecutive(values, hand_value):
                rank = 'Straight'
            else:
                rank = 'High Card'
            rank_value = hand_value
        else:
            if unique_values == 4:
                rank = 'One Pair'
            elif unique_values == 3:
                rank = 'Three of a Kind' if max(counted_values.values()) == 3 else 'Two Pairs'
            else:
                rank = 'Four of a Kind' if max(counted_values.values()) == 4 else 'Full House'
            rank_value = get_rank_value(counted_values)
        return rank, rank_value, hand_value

    def is_winner(hands: list[str, ...]) -> bool:
        player_1, player_2 = map(get_rank, [hands[:5], hands[5:]])
        if hand_ranks[player_1[0]] > hand_ranks[player_2[0]]:
            return True
        elif hand_ranks[player_1[0]] == hand_ranks[player_2[0]]:
            if player_1[1] > player_2[1]:
                return True
            elif player_1[1] == player_2[1]:
                return player_1[2] > player_2[2]
        return False

    hand_ranks = {hand: rank for rank, hand in enumerate(['High Card', 'One Pair', 'Two Pairs', 'Three of a Kind',
                                                          'Straight', 'Flush', 'Full House', 'Four of a Kind',
                                                          'Straight Flush', 'Royal Flush'])}
    card_ranks = {card: rank for rank, card in enumerate(['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K',
                                                          'A'])}
    return sum(map(is_winner, [i.split(' ') for i in open(path).read().split('\n')]))
