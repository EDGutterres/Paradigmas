a,b,c = input().split()
a = int(a)
b = int(b)
c = int(c)

func1 = lambda a,b,c: a if a>b and a>c else b if b>a and b>c else c if c>a and c>b else "N tem maior"

print(func1(a,b,c))