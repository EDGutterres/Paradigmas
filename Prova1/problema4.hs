data Ponto = DoisD Int Int
data Forma = Retangulo Ponto Ponto

estahDentro :: Forma -> Ponto -> Bool
estahDentro (Retangulo (DoisD x1 y1) (DoisD x2 y2)) (DoisD x y) = if ((x >= x1 && x <= x2) || (x >= x2 && x <= x1)) && ((y >= y1 && y <= y2) || (y >= y2 && y <= y1)) then True else False

pontosDentro :: Forma -> [Ponto] -> [Ponto]
pontosDentro _ [] = []
pontosDentro forma (a:b) = if (estahDentro forma a == True) then [a] ++ pontosDentro forma b else pontosDentro forma b

pontosFora :: Forma -> [Ponto] -> [Ponto]
pontosFora _ [] = []
pontosFora forma (a:b) = if (estahDentro forma a == False) then [a] ++ pontosDentro forma b else pontosDentro forma b

dentro :: Forma -> [Ponto] -> [[Ponto]]
dentro (Retangulo (DoisD x1 y1) (DoisD x2 y2)) (a:b) = [pontosDentro (Retangulo (DoisD x1 y1) (DoisD x2 y2)) (a:b)] ++ [pontosFora (Retangulo (DoisD x1 y1) (DoisD x2 y2)) (a:b)]

main = do
    let retangulo = (Retangulo (DoisD 0 0) (DoisD 5 5))
    let p1 = (DoisD 1 1)
    let p2 = (DoisD 2 2)
    let p3 = (DoisD 3 3)
    let p6 = (DoisD 6 6)
    let listaP = p1:p2:p3:p6:[]
    putStrLn (show (dentro retangulo listaP))