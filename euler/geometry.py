def triangle_area(a: (int, int), b: (int, int), c: (int, int)) -> float:
    """Get area of triangle using coordinates of points

    Args:
        a, b, c: Tuple-like points where first element is coordinate by x and second by y

    Examples:
        >>> print(triangle_area((0, 0), (0, 3), (4, 0)))
        6.0
        >>> print(triangle_area((-23, 11), (19, 95), (-12, 114)))
        1701.0
    """
    return abs((a[0] - c[0]) * (b[1] - a[1]) - (a[0] - b[0]) * (c[1] - a[1])) / 2
