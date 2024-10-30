{-
ZADANIE 1 
Napisać funkcję dwuargumentową, która przyjmuje liczby x, y oraz
zwraca wartość
x^2 + 2xy / y^2

Wykorzystując napisaną definicję funkcji oraz ustalenie wartości na
jednym z argumentów zdefiniować funkcję przyjmującą liczbę x
oraz zwracającą
25 + 10y / y^2 
-}

obliczWartosc1 :: Double -> Double -> Double
obliczWartosc1 x y = (x^2 + 2*x*y)/y^2

obliczWartoscUst :: Double -> Double
obliczWartoscUst x = obliczWartosc1 5 x

{-
ZADANIE 2
Wykorzystując funkcję-}
sumaWartosci :: (Int -> Int) -> (Int -> Int) -> Int -> Int -> Int
sumaWartosci f g x y = (f x) + (g y)
{- zdefiniować funkcję, która przyjmuje liczby x, y oraz zwraca
wartość 4x + 3y
-}

f :: Int -> Int
f x = 4*x

g :: Int -> Int
g x = 3*x

obliczWartosc2 :: Int -> Int -> Int
obliczWartosc2 x y = sumaWartosci f g x y

{-
ZADANIE 3
Zapisać funkcję
ocena :: Double -> String
ocena 2.0 = "niezaliczone"
ocena 5.0 = "brawo!"
ocena x = "wpisane masz " ++ show x
stosując dozory (guards) zamiast dopasowania do wzorca.
-}

ocena :: Double -> String
ocena x | x == 2.0  = "niezaliczone"
        | x == 5.0 = "brawo!"
        | otherwise = "wpisane masz " ++ show x

{-
ZADANIE 4
Liczby Stirlinga I rodzaju zdefiniowane są następującymi
zależnościami:

s(0, 0) = 1,
s(n, 0) = 0, dla n ⩾ 1
s(n, n) = 1, dla n ⩾ 1
s(n, k) = (n − 1)s(n − 1, k) + s(n − 1, k − 1), dla n ⩾ 1, n ⩾ k,
k ⩾ 1
Napisać funkcję obliczającą s(n, k).
-}

s :: Integer -> Integer -> Integer
s x y | x == y = 1
      | y == 0 = 0
      | otherwise = (x-1)*(s (x-1) y) + s (x-1) (y-1)


{-
ZADANIE 5
Napisać stosując rekurencję funkcję o sygnaturze
iloczynListy :: [Integer] -> Integer
która przyjmuje listę liczba naturalnych i zwraca jej iloczyn.
Wykorzystać tę funkcję do obliczenia 1000!.
-}

iloczynListy :: [Integer] -> Integer
iloczynListy [] = 0
iloczynListy list = iloczynListyNP(list)

iloczynListyNP :: [Integer] -> Integer
iloczynListyNP list | list == [] = 1
                    | otherwise = (last list) * iloczynListyNP(init list)

{-
ZADANIE 6
Napisać funkcję
merge :: [Int] -> [Int] -> [Int]
łączącą dwie posortowane niemalejąco listy w jedną posortowaną
niemalejąco listę. Używając tej funkcji napisać funkcję
mergeSort :: [Int] -> [Int]
sortującą niemalejąco listę za pomocą algorytmu merge sort.
Pomocna może być funkcja length zwracająca długość listy.
-}

merge :: [Int] -> [Int] -> [Int]
merge [] listB = listB
merge listA [] = listA
merge listA listB | head listA < head listB = [head listA] ++ merge (tail listA) listB
                  | otherwise = [head listB] ++ merge (tail listB) listA

mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort list = merge (mergeSort (take (div (length list) 2) list)) (mergeSort (drop (div (length list) 2) list))

{-
ZADANIE 7
Napisać funkcję
czyDoskonala :: Int -> Bool
sprawdzającą, czy podana liczba jest doskonała (liczba naturalna
jest doskonała, jeśli jest sumą wszystkich swoich dzielników
mniejszych od samej liczby, np. 6 jest liczbą doskonałą, ponieważ 6
= 1 + 2 + 3, a dowolna liczba pierwsza nie jest liczbą doskonałą).
Zadanie należy zrobić nie wykorzystując funkcji Haskella
wykraczających poza te przedstawione na pierwszych zajęciach.
Wskazówka: Napisać pomocnicze funkcje, który zostaną
wykorzystane, aby zrealizować funkcję z zadania, w szczególności
funkcję dzielniki :: (Int,[Int]) -> [Int], która wywołana
na liczbie n oraz liście złożonej z samej jedynki zwróci listę
wszystkich dzielników n
-}

dzielniki :: Int -> [Int]
dzielniki n = dzielnikii(n, [1])

dzielnikii :: (Int,[Int]) -> [Int]
dzielnikii (1,lista) = tail lista
dzielnikii (n, lista) | (div n (head lista)) == 1 = dzielnikii (1, lista)
                      | otherwise = if (mod n (head lista)) == 0 then dzielnikii(n, ((head lista) +1):(head lista):(tail lista))
                                    else dzielnikii (n, (((head lista)+1):(tail lista)))

sumaElementow :: [Int] -> Int
sumaElementow [] = 0
sumaElementow lista = (head lista) + sumaElementow(tail lista)

czyDoskonala :: Int -> Bool
czyDoskonala n = if sumaElementow(dzielniki n) == n then True else False