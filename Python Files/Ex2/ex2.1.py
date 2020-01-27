x,y = input().split()
x = bool(int(x))
y = bool(int(y))
func1 = lambda x,y: x ^ y
print(func1(x,y))