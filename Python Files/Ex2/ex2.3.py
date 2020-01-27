n = input()
n = int(n)

func1 = lambda n: n if n < 2 else func1(n-1) + func1(n-2)
print(func1(n))