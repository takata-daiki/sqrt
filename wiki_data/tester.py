#!/usr/bin/env python3

import math
import a2_test as testpy

clear = True
for i in range(1, 65535):
    ans = testpy.calc(i)
    large = math.sqrt(i)
    small = large - 1./256
    # over = large + 1./256
    if not (small <= ans and ans <= large):
        print("i=", i, ", small=", small, ", ans=", ans, ", large=", large)
        clear = False

if clear:
    print("all ok!")

