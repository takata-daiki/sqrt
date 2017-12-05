#!/usr/bin/env python3

MOD = 2 ** 16

def func0():
    if j < 0:
        return x1 << -j
    else:
        return x1 >> j

def func1():
    if j < 0:
        return y >> -j
    else:
        return y << j

x1 = int(input(), 16)
x0 = 0
a = 0
y = 0
n = 0
c = 0

t = x1
while t > 0:
    t >>= 1
    n += 1
n += 16
n += n & 1

print(hex(x1), '=', x1)
print(  '{:2}'.format('i'),
        '{:1}'.format('c'),
        '{:6}'.format('a'),
        '{:8}'.format('y'),
        '{:6}'.format('x1'),
        '{:6}'.format('x0'),
        '{:6}'.format('x21'),
        '{:6}'.format('x20'),
        '{:6}'.format('y21'),
        '{:6}'.format('y20'),
        )

for i in range(n, -1, -2):
    j = i - 16
    y21 = 0
    a <<= 1
    y <<= 1
    if y >= MOD:
        y %= MOD  # 下16ビットをとる
        y21 += 1
    y20 = 1 | y
    c = True
    f0 = func0() % MOD
    x20 = x0 >> i
    x20 += f0
    x21 = x1 >> i
    if x21 < y21:
        c = False
    if x21 == y21:
        if x20 < y20:
            c = False
    if c:
        a += 1
        y += 1
        x1 -= func1()
        x0 -= (y << i) % MOD  # 下16ビットをとる
        if x0 < 0:
            x1 -= 1
            x0 += MOD  # 下16ビットをとる
        y += 1

    print(  '{:02}'.format(i),
            '{:1}'.format(c),
            '{:#06x}'.format(a),
            '{:#08x}'.format(y),
            '{:#06x}'.format(x1),
            '{:#06x}'.format(x0),
            '{:#06x}'.format(x21),
            '{:#06x}'.format(x20),
            '{:#06x}'.format(y21),
            '{:#06x}'.format(y20),
            )

print(hex(a), '=', a / 256)
