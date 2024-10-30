{-
ZADANIE 1
Napisać funkcję o sygnaturze
jestPunktemStalym :: (Eq a) => a -> (a -> a) -> Bool
sprawdzającą, czy punkt podany jako pierwszy argument jest
punktem stałym funkcji podanej jako drugi argument.
-}
jestPunktemStalym :: (Eq a) => a -> (a -> a) -> Bool
jestPunktemStalym x f = (f x) == x 

f :: Int -> Int
f x = x + x

g :: Int -> String
g x = "to jest x: " ++ show x

{-
ZADANIE 2
Napisać funkcję dwuargumentową (możliwie najogólniejszą), która
przyjmuje liczby x, y oraz zwraca napis, który informuje nas, czy
iloczyn x i y jest większy od ich sumy. W napisie mają pojawić się
liczby x i y.
-}
czyWiekszy :: (Ord a, Show a, Num a) => a -> a -> String
czyWiekszy x y | x*y>x+y = "Iloczyn " ++ show x ++ " " ++ show y ++ " wiekszy od ich sumy"
               | otherwise = "Iloczyn nie jest wiekszy od sumy " ++ show x ++ " " ++ show y

{-
ZADANIE 3
Zdefiniować nieskończoną listę dodatnich rozwiązań układu
kongruencji:
x ≡ 5 ( mod 6)
x ≡ 3 ( mod 7)
x ≡ 5 ( mod 8
-}
x :: [Int]
x = [x | x <- [1,2..], mod x 6 == 5, mod x 7 == 3, mod x 8 == 5]

{-
ZADANIE 4
Zdefiniować funkcję dzielniki :: Int -> [Int] zwracającą
listę dzielników liczby z wykorzystaniem funkcji z dzisiejszych
materiałów (por. zadanie do pierwszych ćwiczeń z liczbą
doskonałą).
-}

dzielniki :: Int -> [Int]
dzielniki 1 = []
dzielniki n = [d | d <- [1..(div n 2)], mod n d == 0]

{-
ZADANIE 5
Napisać funkcję o sygnaturze
ktoraCwiartka :: [(Int,Int)] -> Int
przyjmującą listę punktów na płaszczyźnie i zwracającą numer
ćwiartki, w której jest najwięcej punktów (punkty na osiach
liczymy dla obu przylegających ćwiartek, w szczególności (0,0)
liczymy do każdej ćwiartki). Jeśli w kilku ćwiartkach występuje tyle
samo punktów, zwrócić numer dowolnej z nich.
-}

licznik :: [(Int,Int)] -> [(Int,Int,Int,Int)] -- wskazuje na ćwiartkę danego punktu, ćwiartki ułożone odpowiednio (1,2,3,4)
licznik [] = [(0,0,0,0)]
licznik [(0,0)] = [(1,1,1,1)]
licznik [(0,y)] | y > 0 = [(1,1,0,0)]
                | otherwise = [(0,0,1,1)]
licznik [(x,0)] | x > 0 = [(1,0,0,1)]
                | otherwise = [(0,1,1,0)]
licznik [(x,y)] | x>0,y>0 = [(1,0,0,0)]
                | x<0,y>0 = [(0,1,0,0)]
                | x<0,y<0 = [(0,0,1,0)]
                | x>0,y<0 = [(0,0,0,1)]
licznik (x:xs) = licznik [x] ++ licznik xs

sumaElementow :: [(Int,Int,Int,Int)] -> (Int,Int,Int,Int) -- dodaje punkty z R^4
sumaElementow [] = (0,0,0,0)
sumaElementow [(a,b,c,d),(x,y,p,q)] = (a+x,b+y,c+p,d+q)
sumaElementow lista = sumaElementow [(head lista),(sumaElementow (tail lista))]

zwrocNrCwiartki :: (Int,Int,Int,Int) -> Int                  -- zwraca ćwiartkę gdzie leży najwięcej punktów,
zwrocNrCwiartki (a,b,c,d) | a == max a (max b (max c d)) = 1 -- jeśli dwie mają największą, równą sobie liczbę, zwraca
                          | b == max a (max b (max c d)) = 2 -- pierwszą w case
                          | c == max a (max b (max c d)) = 3
                          | d == max a (max b (max c d)) = 4

ktoraCwiartka :: [(Int,Int)] -> Int -- odpowiednio składa powyższe funkcje, przyjmując jako arg listę punktów z R^2
ktoraCwiartka [] = 0
ktoraCwiartka lista = zwrocNrCwiartki (sumaElementow (licznik lista))

{-
ZADANIE 6
Napisać funkcję o sygnaturze
podlisty :: [Integer] -> [[Integer]]
która przyjmuje listę liczb całkowitych i zwraca listę wszystkich jej
podlist. Wykorzystać ją do napisania funkcji o sygnaturze
podlistyDlugosci :: Integer -> [Integer] -> [[Integer]]
która przyjmuje liczbę k oraz listę liczb całkowitych i zwraca listę
wszystkich podlist podanej listy o długości k.
-}

podlisty :: (Eq a) => [a] -> [[a]]
podlisty [] = [[]]
podlisty (x:xs) = [x:podlista | podlista <- podlisty xs] ++ podlisty xs

dlugoscListy :: (Eq a) => [a] -> Int
dlugoscListy [] = 0
dlugoscListy [x] = 1
dlugoscListy lista = 1 + dlugoscListy (tail lista)

podlistyDlugosci :: (Eq a) => Int -> [a] -> [[a]]
podlistyDlugosci 0 lista = [[]]
podlistyDlugosci k lista = [podlista | podlista <- podlisty lista, dlugoscListy podlista == k]

{-
ZADANIE 7
przyjmującą funkcję oraz listę liczb naturalnych, która wykonuje
podaną funkcję na każdym elemencie listy (czyli dla funkcji f oraz
listy [x1, . . . , xn] mamy otrzymać [f (x1), . . . , f (xn)]). Wykorzystać
ją do podniesienia każdej z liczb na liście [1..10] do kwadratu
-}

przeksztalcListe :: (Int -> Int) -> [Int] -> [Int]
przeksztalcListe f lista = [f x | x <- lista]


-- | mod (mod n 2) == 0 = [foldl (\lista podlista -> (podlista + (reversee podlista)) : lista)] [] (podlistyDlugosci round(n/2) poczList (div n 2))
--      | otherwise = [foldl (\lista podlista -> (podlista + (reversee podlista)) : lista)] [] (podlistyDlugosci (div n 2) 'a':poczList (div n 2)) ++ [foldl (\lista podlista -> (podlista + (reversee podlista)) : lista)] [] (podlistyDlugosci (div n 2) 'b':poczList (div n 2))