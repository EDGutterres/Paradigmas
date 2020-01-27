data Arvore = Null | No Int Arvore Arvore

minhaArvore :: Arvore
minhaArvore = No 52 (No 31 (No 12 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 64 Null Null))

outraArvore :: Arvore
outraArvore = No 42 (No 33 (No 27 (No 33 (No 33 Null Null) Null) (No 17 Null Null)) (No 7 Null Null)) (No 12 (No 3 Null Null) (No 11 (No 12 Null Null) Null))

somaElementos :: Arvore -> Int
somaElementos Null = 0
somaElementos (No n esq dir) = n + (somaElementos esq) + (somaElementos dir)

buscaElemento :: Arvore -> Int -> Bool
buscaElemento Null _ = False
buscaElemento (No n esq dir) x 
    | (n == x) = True                           
    | otherwise = (buscaElemento esq x) || (buscaElemento dir x)

limiteSup :: Int
limiteSup = 1000 --Define um limite superior para o maior número

minimo :: Int -> Int -> Int
minimo x y | (x < y) = x
           | otherwise = y

minimoElemento :: Arvore -> Int
minimoElemento Null = limiteSup 
minimoElemento (No n esq dir) = 
    minimo n (minimo (minimoElemento esq) (minimoElemento dir))

maiorProfundidadeElemento :: Arvore -> Int -> Int
maiorProfundidadeElemento Null _ = -1
maiorProfundidadeElemento (No n esq dir) x =
    --Se o elemento não estiver na árvore retorna -1
    if buscaElemento (No n esq dir) x == False then
        -1
    --Se o elemento existir em alguma das subárvores, adiciona +1 à maior altura entre as duas
    else if (maiorProfundidadeElemento esq x) >= 0 && (maiorProfundidadeElemento esq x) >= (maiorProfundidadeElemento dir x) then
        1 + maiorProfundidadeElemento esq x
    else if (maiorProfundidadeElemento dir x) >= 0 && (maiorProfundidadeElemento esq x) < (maiorProfundidadeElemento dir x) then
        1 + maiorProfundidadeElemento dir x
    --Se não existir em alguma das subárvores, significa que ele está em seu nó final, não precisando adicionar nada à altura, pois já foi adicionado anteriormente, retornando 0
    else
        0

--Verifica se um numero é primo
ehPrimo :: Int -> Bool
ehPrimo 1 = False
ehPrimo 2 = True
ehPrimo n =
    not((length [x | x <- [2 .. n-1], mod n x == 0]) > 0)

folhasPrimos :: Arvore -> [Int]
folhasPrimos Null = []
--A função que recebe uma folha como parâmetro apenas retorna o elemento
--Sozinho na lista se ele for primo
folhasPrimos (No n Null Null) = 
    if ehPrimo n then
        [n]
    else
        []
--Quando não recebe uma folha, repete a função recursivamente até encontrar
--Uma folha, e então concatena os resultados
folhasPrimos (No n esq dir) =
    folhasPrimos esq ++ folhasPrimos dir
    
--Utilizamos a função feita no simulado da prova, que retorna o 
--Numero de ocorrencias de um certo elemento na árvore
ocorrenciasElemento :: Arvore -> Int -> Int
ocorrenciasElemento Null _ = 0
ocorrenciasElemento (No n esq dir) x =
    if n == x then
        oc + 1
    else
        oc
    where
        oc = ocorrenciasElemento esq x + ocorrenciasElemento dir x


elementosRepetidos :: Arvore -> Int -> Int
elementosRepetidos Null _ = 0
elementosRepetidos (No n esq dir) x =
    --Verifica se o numero de ocorrencias é igual ao número passado como parâmetro
    --Se sim, soma 1 à conta. Se não, continua verificando os outros nós sem somar 1
    if ocorrenciasElemento (No n esq dir) n == x then
        1 + elementosRepetidos esq x + elementosRepetidos dir x
    else
        elementosRepetidos esq x + elementosRepetidos dir x

main = do 
    putStrLn (show (somaElementos minhaArvore))
    putStrLn (show (buscaElemento minhaArvore 30))
    putStrLn (show (buscaElemento minhaArvore 55))
    putStrLn (show (minimoElemento minhaArvore))
    putStrLn (show (maiorProfundidadeElemento outraArvore 33))
    putStrLn (show (maiorProfundidadeElemento outraArvore 12))
    putStrLn (show (maiorProfundidadeElemento outraArvore 7))
    putStrLn (show (folhasPrimos outraArvore))
    putStrLn (show (folhasPrimos minhaArvore))
    putStrLn (show (elementosRepetidos outraArvore 2))
    putStrLn (show (elementosRepetidos outraArvore 1))
    putStrLn (show (elementosRepetidos minhaArvore 1))
    putStrLn (show (elementosRepetidos minhaArvore 2))