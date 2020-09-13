def compute() -> int:
    months = [31, 0, 31, 30, 31, 30, 31, 31, 30 , 31, 30, 31]
    day = 2
    result = 0
    for year in range(1901, 2001):
        months[1] = 28 + year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
        for month in range(12):
            day += months[month] % 7
            if day % 7 == 0:
                result += 1
    return result
