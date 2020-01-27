contarAteN :: Int -> Int -> Int
contarAteN n i = 
    if ((mod i 5) == 0) then 
        i + 1 + contarAteN (n+1) (i+1)
    else 
        if (i == n) then 
            i 
        else i + contarAteN n (1+1)

somaMultiplos2 :: Int -> Int
somaMultiplos2 n = 2 * contarAteN n 1

main = do
    print(somaMultiplos2 5)