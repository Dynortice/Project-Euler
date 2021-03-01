from json import loads
from tqdm import tqdm


def print_result(result: dict) -> None:
    rewards = 0
    for value in result.values():
        if isinstance(value, int):
            rewards += value
        else:
            rewards += sum(value.values())
    print(f'Draws: {rewards // 3}\nCoins: {result["Coins"]}\nFish: {result["Fish"]}\nWood: {result["Wood"]}\n'
          f'Stone: {result["Stone"]}\nIron: {result["Iron"]}\nExperience: {result["Experience"]}\n'
          f'Captain: {result["Captain"]}\nGems: {result["Gem"]}\nShips: {result["Ship"]}')


def init() -> dict:
    return {'Coins': 0, 'Fish': 0, 'Wood': 0, 'Stone': 0, 'Iron': 0, 'Experience': 0, 'Captain': 0,
            'Gem': {50: 0, 100: 0, 400: 0, 1000: 0, 4000: 0}, 'Ship': {1: 0, 2: 0}}


def add_rewards(rewards: list, result: dict, add: int = 1) -> dict:
    for reward in rewards:
        if 'Gem' in reward:
            result['Gem'][int(reward.replace('Gem_', ''))] += add
        elif 'Ship' in reward:
            result['Ship'][int(reward.replace('Ship_', ''))] += add
        else:
            result[reward] += add
    return result


def delete_rewards(cargo: dict, result: dict, stop_draw: int = 0, sure_draw: int = 0) -> dict:
    for draw, rewards in cargo.items():
        if int(draw) == stop_draw:
            break
        if int(draw) > sure_draw:
            result = add_rewards(rewards, result, -1)
    return result


def only_draws(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                result = add_rewards(rewards, result)
    return result


def draws_all_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if sum(result['Ship'].values()) - last_result == 3:
                    break
    return result


def draws_small_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if result['Ship'][2] - last_result == 2:
                    break
    return result


def draws_small_ship(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if result['Ship'][2] - last_result == 1:
                    break
    return result


def draws_small_ships_additional(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            last_small_ships = result['Ship'][2]
            small_ships = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if sum(result['Ship'].values()) - last_result == 3:
                    break
                elif result['Ship'][2] - last_small_ships == 2:
                    if small_ships == 2:
                        break
                    else:
                        small_ships = 2
    return result


def draws_small_ship_additional(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            small_ships = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if result['Ship'][2] - last_result == 2:
                    break
                elif result['Ship'][2] - last_result == 1:
                    if small_ships == 1:
                        break
                    else:
                        small_ships = 1
    return result


def draws_large_ship(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][1]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if result['Ship'][1] - last_result == 1:
                    break
    return result


def draws_large_ship_additional(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            last_large_ships = result['Ship'][1]
            large_ships = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if (sum(result['Ship'].values()) - last_result == 3) or \
                        (large_ships and sum(result['Ship'].values()) - last_result == 2):
                    break
                elif result['Ship'][1] - last_large_ships == 1:
                    if large_ships:
                        break
                    else:
                        large_ships = 1
    return result


def draws_large_ship_additional_2(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            last_large_ships = result['Ship'][1]
            last_small_ships = result['Ship'][2]
            large_ships = 0
            small_ships = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                if sum(result['Ship'].values()) - last_result == 3:
                    break
                elif result['Ship'][1] - last_large_ships == 1:
                    if large_ships and small_ships:
                        break
                    elif large_ships and not small_ships:
                        if result['Ship'][2] - last_small_ships == 0:
                            break
                        else:
                            small_ships += 1
                    else:
                        large_ships += 1
    return result


def sure_all_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            sure_draw = 0
            sure_ships = 0
            draw = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    delete_rewards(cargo, result, int(draw), sure_draw)
                    break
                add_rewards(rewards, result)
                if sum(result['Ship'].values()) - last_result == 3:
                    break
                elif sum(result['Ship'].values()) - last_result > sure_ships:
                    sure_ships = sum(result['Ship'].values()) - last_result
                    sure_draw = int(draw)
            else:
                delete_rewards(cargo, result, int(draw), sure_draw)
    return result


def sure_small_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            sure_draw = 0
            sure_ships = 0
            draw = 0
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    delete_rewards(cargo, result, int(draw), sure_draw)
                    break
                add_rewards(rewards, result)
                if result['Ship'][2] - last_result == 2:
                    break
                elif result['Ship'][2] - last_result > sure_ships:
                    sure_ships = result['Ship'][2] - last_result
                    sure_draw = int(draw)
            else:
                delete_rewards(cargo, result, int(draw), sure_draw)
    return result


def sure_small_ship(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    delete_rewards(cargo, result, int(draw))
                    break
                add_rewards(rewards, result)
                if result['Ship'][2] - last_result == 1:
                    break
            else:
                delete_rewards(cargo, result)
    return result


def sure_large_ship(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][1]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    delete_rewards(cargo, result, int(draw))
                    break
                add_rewards(rewards, result)
                if result['Ship'][1] - last_result == 1:
                    break
            else:
                delete_rewards(cargo, result)
    return result


def gem_all_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = sum(result['Ship'].values())
            last_gems = sum(key * value for key, value in result['Gem'].items())
            sure_ships = 0
            sure_draw = 0
            profit = [-i * 200 for i in range(61)]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                profit[int(draw)] = sum(key * value
                                        for key, value in result['Gem'].items()) - last_gems - int(draw) * 200
                if sum(result['Ship'].values()) - last_result > sure_ships:
                    sure_ships = sum(result['Ship'].values()) - last_result
                    sure_draw = int(draw)
            delete_rewards(cargo, result, n + 1, profit.index(max(profit[sure_draw:]), sure_draw))
    return result


def gem_small_ships(n: int) -> dict:
    result = init()
    for line in open('../seaport/test.json'):
        player = loads(line)
        for cargo in player[list(player.keys())[0]].values():
            last_result = result['Ship'][2]
            last_gems = sum(key * value for key, value in result['Gem'].items())
            sure_ships = 0
            sure_draw = 0
            profit = [-i * 200 for i in range(61)]
            for draw, rewards in cargo.items():
                if int(draw) > n:
                    break
                add_rewards(rewards, result)
                profit[int(draw)] = sum(key * value
                                        for key, value in result['Gem'].items()) - last_gems - int(draw) * 200
                if result['Ship'][2] - last_result > sure_ships:
                    sure_ships = result['Ship'][2] - last_result
                    sure_draw = int(draw)
            delete_rewards(cargo, result, n + 1, profit.index(max(profit[sure_draw:]), sure_draw))
    return result


def save_results() -> None:
    for function in tqdm(['only_draws', 'draws_all_ships', 'draws_small_ships', 'draws_small_ship',
                          'draws_small_ships_additional', 'draws_small_ship_additional', 'draws_large_ship',
                          'draws_large_ship_additional', 'draws_large_ship_additional_2', 'sure_all_ships',
                          'sure_small_ships', 'sure_small_ship', 'sure_large_ship', 'gem_all_ships',
                          'gem_small_ships']):
        print(f'\nstarted {function}')
        total = ''
        for i in tqdm(range(60, 0, -1)):
            result = eval(f'{function}({i})')
            total += ';'.join(map(str, [i, result['Coins'], result['Fish'], result['Wood'], result['Stone'], result['Iron'],
                                        result['Experience'], result['Captain'], *result['Gem'].values(),
                                        *result['Ship'].values()])) + '\n'
        open(f'../../Documents/Seaport/{function}.csv', 'w').write(total)
