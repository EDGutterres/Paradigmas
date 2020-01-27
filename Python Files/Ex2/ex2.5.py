from math import sqrt

print("Informe o primeiro ponto")
x1,y1,z1 = input().split()
x1 = float(x1)
y1 = float(y1)
z1 = float(z1)
print("Informe o segundo ponto")
x2,y2,z2 = input().split()
x2 = float(x2)
y2 = float(y2)
z2 = float(z2)

func1 = lambda x1,y1,z1,x2,y2,z2: sqrt((x2-x1)**2 + (y2-y1)**2 + (z2-z1)**2)

print(func1(x1,y1,z1,x2,y2,z2))