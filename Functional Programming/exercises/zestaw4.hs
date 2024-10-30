{- 
ZADANIE 1
Podać przykład działania, wartości początkowej i listy, gdzie
wywołanie foldl i foldr da różne wyniki. Rozpisać, jak wygląda
obliczenie w obu przypadkach.
-}

różnicaListyLewa :: Num a => [a] -> a
różnicaListyLewa xs = foldl (-) 0 xs

różnicaListyPrawa :: Num a => [a] -> a
różnicaListyPrawa xs = foldr (-) 0 xs


{- 
ZADANIE 2
Zaimplementować reverse na liście używając foldl i foldr (po
jednej definicji; można założyć, że listy są skończone).
-}

reverseR :: [a] -> [a]
reverseR = foldr (\x acc -> acc ++ [x]) []
 
reverseL :: [a] -> [a]
reverseL = foldl (\acc x -> x : acc) []

{- 
ZADANIE 3
Zaimplementować map używając foldl i foldr (po jednej
definicji; można założyć, że listy są skończone).
Uwaga: Zauważmy, że w drugą stronę (fold za pomocą map) nie
jest to wykonalne, ponieważ map zwraca nam zawsze listę.
-}

foldrMap :: (a -> b) -> [a] -> [b]
foldrMap f = foldr (\x list -> (f x) : list) []
 
foldlMap :: (a -> b) -> [a] -> [b]
foldlMap f = foldl (\list x -> list ++ [f x]) []

{- 
ZADANIE 4
Zdefiniować używając foldl lub foldr funkcję
doDziesietnego :: Int -> [Int] -> Int
przyjmującą podstawę systemu liczbowego oraz reprezentację liczby
w tym systemie (kolejne wyrazy to kolejne ”cyfry”) i zwracającą jej
reprezentację w systemie dziesiętnym. Przykładowo
doDziesietnego 2 [1,0,1,1] powinno zwrócić 11, a
doDziesietnego 16 [15,15] powinno zwrócić 255.
-}

doDziesietnego :: Int -> [Int] -> Int
doDziesietnego a x = foldl (\x y -> a*x+y) 0 x

{- 
ZADANIE 5
Zaimplementować używając foldl lub foldr funkcję
ktoraCwiartka :: [(Int,Int)] -> Int
przyjmującą listę punktów na płaszczyźnie i zwracającą numer
ćwiartki, w której jest najwięcej punktów (w przypadku remisu
dowolną ćwiartkę, w której jest najwięcej; to zadanie było już na
drugich ćwiczeniach, jednak bez użycia fold).


ktoraCwiartka :: [(Int,Int)] -> Int
ktoraCwiartka = 

f :: (Int,Int) -> Int
f (x,y) | x>0, y>0 = 1
        | x>0, y<0 = 4
        | x<0, y<0 = 3
        | otherwise = 2
-}

pom :: Int -> Int -> Int
pom a b | a >= 0 && b >= 0 = 1
        | a >= 0 && b <= 0 = 2
        | a <= 0 && b <= 0 = 3
        | otherwise = 4

plusczyminus :: Int -> Int
plusczyminus x | x > 0 = 1
               | x < 0 = -1
               | otherwise = 0

ktoraCwiartka :: [(Int,Int)] -> Int
ktoraCwiartka x = pom (foldl (\y z -> y + (plusczyminus (fst z))) 0 x) (foldl (\y z -> y + (plusczyminus (snd z))) 0 x)

{- 
ZADANIE 6
Napisać funkcję
dlaKazdego :: (a -> Bool) -> [a] -> Bool
przyjmującą warunek (funkcję jednoargumentową) oraz listę, i
zwracającą prawdę, jeśli warunek jest spełniony dla każdego
elementu listy oraz fałsz w przeciwnym przypadku. Zdefiniować też
funkcję
istnieje :: (a -> Bool) -> [a] -> Bool
przyjmującą warunek (funkcję jednoargumentową) oraz listę, i
zwracającą prawdę, jeśli warunek jest spełniony dla przynajmniej
elementu listy oraz fałsz w przeciwnym przypadku.
W obu przypadkach można założyć, że listy są skończone.
-}

dlaKazdego :: (a -> Bool) -> [a] -> Bool
dlaKazdego f xs = foldl(\x1 x2 -> x1 && f x2) True xs

istnieje :: (a -> Bool) -> [a] -> Bool
istnieje f xs = foldl(\x1 x2 -> x1 || f x2) False xs

{- 
ZADANIE 7
Rozważmy poniższą definicję:
fibonacci :: [Integer]
fibonacci = 0 : 1 : (zipWith (+)
fibonacci (tail fibonacci))

Wytłumaczyć, dlaczego poprawnie oblicza ona ciąg Fibonacciego
(wartością jest istotnie nieskończona lista zawierająca wszystkie
jego elementy).
Wskazówka: Dla list nieskończonych Haskell liczy kolejny element
dopiero wtedy, kiedy musi
-}






