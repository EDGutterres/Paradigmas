import sys

loop = 1

while loop<65:

    while True:
        try:
            n, q = input().split()
            n = int(n)
            q = int(q)
            if n==0 and q==0:
                sys.exit()
            if n<0 or q<0 or n>10000 or q>10000:
                raise ValueError
            break
        except ValueError:
            break

    m = []
    c = []

    for i in range (n):
        while True:
            try:
                mIn = int(input())
                m.append(mIn)
                if mIn<0 or mIn>10000:
                    raise ValueError
                break
            except ValueError:
                break
    
    m.sort()
    
    for i in range (q):
        while True:
            try:
                cIn = int(input())
                c.append(cIn)
                if cIn<0 or cIn>10000:
                    raise ValueError
                break
            except ValueError:
                break
    
    print("CASE# %i:" % loop)

    for i in range (len(c)):
        if m.__contains__(c[i]):
            print("%i found at %d" % (c[i], m.index(c[i])+1))
        else:
            print("%i not found" % c[i])
    loop+=1