f :: Int -> Int
f 0 = 0
f 1 = 1

-- a função div retorna a divisão inteira truncada para baixo

f n = f (n - 1) `div` 2 + 3 * f (n - 2)

-- serao impressos os 12 primeiros numeros de Fritz
main = do
    print (f 0)
    print (f 1)
    print (f 2)
    print (f 3)
    print (f 4)
    print (f 5)
    print (f 6)
    print (f 7)
    print (f 8)
    print (f 9)
    print (f 10)
    print (f 11)