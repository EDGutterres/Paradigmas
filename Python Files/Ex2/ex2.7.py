x = input().split()

for i in range (len(x)):
    x[i] = int(x[i])

func1 = lambda x: "Par" if x%2==0 else "Impar"

print(list(map(func1, x)))