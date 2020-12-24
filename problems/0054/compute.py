HAND_RANKS = {hand: rank for rank, hand
              in enumerate(['High Card', 'One Pair', 'Two Pairs', 'Three of a Kind', 'Straight', 'Flush',
                            'Full House', 'Four of a Kind', 'Straight Flush', 'Royal Flush'])}
CARD_RANKS = {card: rank for rank, card
              in enumerate(['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'])}


def compute(path: str) -> int:
    def is_flush(suits: list) -> bool:
        return len(set(suits)) == 1

    def is_royal(values: list) -> bool:
        return sum(values) == 50

    def is_consecutive(values: list, hand_value: int) -> bool:
        return sum(values) == 5 * (hand_value - 2)

    def get_rank_value(counted_values: {int: int}) -> int:
        max_kinds = max(counted_values.values())
        return max(value for value, kinds in counted_values.items() if kinds == max_kinds)

    def get_rank(cards: list) -> (str, int, int):
        values = list(map(lambda x: CARD_RANKS[x[0]], cards))
        suits = list(map(lambda x: x[1], cards))
        counted_values = {i: values.count(i) for i in set(values)}
        unique_values = len(counted_values)
        hand_value = max(values)
        if unique_values == 5:
            if is_flush(suits):
                if is_consecutive(values, hand_value):
                    if is_royal(values):
                        rank = 'Royal Flush'
                    else:
                        rank = 'Straight Flush'
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
                if max(counted_values.values()) == 3:
                    rank = 'Three of a Kind'
                else:
                    rank = 'Two Pairs'
            else:
                if max(counted_values.values()) == 4:
                    rank = 'Four of a Kind'
                else:
                    rank = 'Full House'
            rank_value = get_rank_value(counted_values)
        return rank, rank_value, hand_value

    def is_winner(hands: [str]) -> bool:
        player_1, player_2 = get_rank(hands[:5]), get_rank(hands[5:])
        if HAND_RANKS[player_1[0]] > HAND_RANKS[player_2[0]]:
            return True
        elif HAND_RANKS[player_1[0]] == HAND_RANKS[player_2[0]]:
            if player_1[1] > player_2[1]:
                return True
            elif player_1[1] == player_2[1]:
                return player_1[2] > player_2[2]
        return False

    wins = []
    for n, game in enumerate(i.split(' ') for i in open(path).read().split('\n')):
        if is_winner(game):
            wins += [n + 1]
    print(wins)
    return sum(map(is_winner, [i.split(' ') for i in open(path).read().split('\n')]))


compute('problems/0054/p054_poker.txt')
