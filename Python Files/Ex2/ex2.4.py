from math import sqrt

a, b, c = input().split()
a = float(a)
b = float(b)
c = float(c)

func1 = lambda a, b, c: (-b + sqrt(b*b - (4*a*c)))/(2*a)

print(func1(a,b,c))