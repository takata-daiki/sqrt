#!/usr/bin/env python3

x = int(input())
a = 0
y = 0
n = 0

t = x
while t > 0:
    t >>= 1
    n += 1

n += n & 1
for i in range(n, -1, -2):
    a <<= 1
    y <<= 1
    c = (1 | y) <= x >> i
    if c:
        a += 1
        y += 1
        x -= y << i
    y += c
    print('c, a, y, x:', c, a, hex(y), hex(x))

print(a)
