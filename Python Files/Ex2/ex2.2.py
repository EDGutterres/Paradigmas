a, b, c = input().split()
a = float(a)
b = float(b)
c = float(c)

func1 = lambda a, b, c: ((a+b+c)/3) >= 6

print(func1(a,b,c))
