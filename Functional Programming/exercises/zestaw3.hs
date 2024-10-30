{-
ZADANIE 1
Napisać używając map i filter funkcję
maleLitery :: [String] -> [String]
przyjmującą listę napisów i zwracającą listę złożoną tylko i
wyłącznie z małych liter alfabetu oryginalnych napisów. Na
przykład na liście [”TeSt”,”TEST”,””] poprawnym wynikiem
będzie [”et",””,””].
Wskazówka: funkcja elem oraz tworzenie list.
-}

maleLitery :: [String] -> [String]
maleLitery x = map (filter pred) x
    where
        pred x = x `elem` ['a'..'z']

{-
ZADANIE 2
Napisać używając map i filter funkcję
dlugoscPalindromow :: [String] -> Int
przyjmującą listę napisów i zwracającą sumę długości tych z nich,
które są palindromami.
Wskazówka: funkcja sum i reverse.
-}

dlugoscPalindromow:: [String] -> Int
dlugoscPalindromow tab = sum (map length (filter pred tab))
    where
        pred x = reverse x == x

{-
ZADANIE 3
Napisać używając iterate funkcję
fib :: (Integer,Integer) -> [(Integer,Integer)]
przyjmującą parę liczb i zwracającą nieskończoną listę, której
kolejny element (x′,y′) powstaje z poprzedniego (x,y) w taki
sposób, że x′ jest równy y, a y′ jest sumą x i y. Używając tej
funkcji wygenerować nieskończoną listę zawierającą kolejne
elementy ciągu Fibonacciego (od 0,1,1,...).
-}

fib :: (Integer, Integer) -> [Integer]
fib (x,y) = map fst (iterate f (x,y))
    where
        f (a,b) = (b, a+b)

{-
ZADANIE 4
Zdefiniować funkcję
dlugosc :: [a] -> Int
działającą jak length, czyli zwracającą długość listy, używając
funkcji map i sum (i nie używając length)
-}

dlugosc :: [a] -> Int
dlugosc tab = sum (map (const 1) tab)

{-
ZADANIE 5
Napisać funkcję
slowaDlugosci :: Char -> Char -> Integer -> [String]
przyjmującą dwa znaki oraz liczbę i zwracającą wszystkie słowa
podanej długości, których literami są podane znaki. Przykładowo
dla ’a’ ’b’ 2 wynikiem powinno być [”aa”,”ab”,”ba”,”bb”].
Słowa nie muszą być podane w tej kolejności, ważne, żeby były
wszystkie
-}

slowaDlugosci :: Char -> Char -> Integer -> [String]
slowaDlugosci a b 0 = [[]]
slowaDlugosci a b n = [z:x | x <- slowaDlugosci a b (n - 1), z <- [a, b]]

{-
ZADANIE 6
Zaimplementować algorytm QuickSort o sygnaturze
quickSort :: (Ord a) => [a] -> [a]
-}

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) =
  let smallerSorted = quickSort [a | a <- xs, a <= x]
      biggerSorted = quickSort [a | a <- xs, a > x]
   in smallerSorted ++ [x] ++ biggerSorted

{-
ZADANIE 7
Używając zipWith zaimplementować map i zip.
Wskazówka: Jeśli listy nie są równej długości, elementy dłuższej
”bez pary” z elementem listy krótszej są pomijane.
-}



{-
ZADANIE 8
Zaimplementować funkcję o sygnaturze
eratosthenes :: Integer -> [Integer]
przyjmującą liczbę n i zwracającą listę liczb pierwszych nie
większych niż n obliczoną metodą Sita Eratostenesa
-}


sub_podlist :: [Integer] -> [Integer] -> [Integer]
sub_podlist (x:xs) (y:ys) | x < y = x:(sub_podlist xs (y:ys))
                          | x == y = sub_podlist xs ys 
                          | otherwise = sub_podlist (x:xs) ys
sub_podlist xs _ = xs

sieve :: [Integer] -> [Integer]
sieve [] = []
sieve (p:xs) = p:sieve (xs `sub_podlist` [p, p+p..])
{-sieve (p:xs) | p < round(sqrt (fromIntegral(last xs))) + 1 = p:sieve (xs `sub_podlist` [p, p+p..])
             | otherwise = []-}

eratosthenes :: Integer -> [Integer]
eratosthenes n = sieve [2..n] {-where m = round(sqrt (fromIntegral n))-}

