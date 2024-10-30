{-
ZADANIE 1
Zdefiniować typ
data Student = Student {imie :: String,
nazwisko :: String,
nrAlbumu :: Int
}
jako instancję Show w taki sposób, aby kolejne wartości pól były
wypisywane po dwukropkach, w kolejnych linijkach
-}

data Student = Student {imie :: String,
nazwisko :: String,
nrAlbumu :: Int
}
janKowalski = Student {imie="Jan",
nazwisko="Kowalski", nrAlbumu=1234567}
instance Show Student
    where
        show (Student imie nazwisko nrAlbumu) = 
                "imie: " ++ imie ++ "\n" ++ "nazwisko: " ++ nazwisko ++ "\n" ++ "nrAlbumu:" ++  (show nrAlbumu)


{-
ZADANIE 2
Zdefiniować typ Calkowite przez Zero, następnik całkowitej oraz
poprzednik całkowitej (podobnie, jak Naturalne na slajdach).
Napisać funkcję, która konwertuje Integer do typu Calkowite
oraz drugą funkcję, które konwertuje Calkowite na Integer.
-}

data Calkowite = Zero | Nastepnik Calkowite | Poprzednik Calkowite deriving (Show, Eq)
 
calToInt :: Calkowite -> Integer
calToInt Zero = 0
calToInt (Nastepnik x) = 1 + calToInt x
calToInt (Poprzednik x) = -1 + calToInt x
 
intToCal :: Integer -> Calkowite
intToCal 0 = Zero
intToCal x
 | x > 0 = Nastepnik (intToCal (x-1))
 | x < 0 = Poprzednik (intToCal (x+1))

{-
ZADANIE 3
Dla typu
data Tree a = Empty | Node a (Tree a) (Tree a)
Oraz drzewa z liczbami typu Integer zdefiniować funkcje, która
sprawdza, czy wszystkie wierzchołki drzewa mają liczby parzyste.
-}

data Tree a = Empty | Node a (Tree a) (Tree a)
allEven :: Tree Integer -> Bool
allEven Empty = True
allEven (Node x left right) | even x = allEven left && allEven right
                            | otherwise = False
tr = Node 4 (Node 4 (Node 2 Empty Empty) (Node 6 Empty Empty)) Empty

{-
ZADANIE 4
Dla typu
data Tree a = Empty | Node a (Tree a) (Tree a)
zdefiniować trzy funkcje, zwracające listę jego elementów w
porządku odpowiednio preorder, inorder oraz postorder.
-}

inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node a left right) = (inorder left) ++ [a] ++ (inorder right)
 
preorder :: Tree a -> [a]
preorder Empty = []
preorder (Node a left right) = a : (preorder left) ++ (preorder right)
 
postorder :: Tree a -> [a]
postorder Empty = []
postorder (Node a left right) = (postorder left) ++ (postorder right) ++ [a]

{-
ZADANIE 5
Zdefiniować typ odpowiadający liczbom całkowitym Gaussa (liczby
zespolone, których część rzeczywista jest całkowita oraz część
urojona jest całkowita). Uczynić typ instancją Show oraz Num.
Ponieważ w Num trzeba zdefiniować wartość bezwzględną oraz
znak, zdefiniować pierwszą jako identyczność, a drugą jako stale
równą jeden. Funkcję show zdefiniować tak, aby liczba a + bi
została wypisana jako a+bi
-}

data Zespolone = Zespolone {
                            a :: Integer,
                            b :: Integer
                            }
 
instance Num Zespolone
    where
        (+) (Zespolone a b) (Zespolone c d) = (Zespolone (a+c) (b+d))
        (*) (Zespolone a b) (Zespolone c d) = (Zespolone (a*c - b*d) (a*d + b*c))
        negate (Zespolone a b) = (Zespolone (-a) (-b))
        signum (Zespolone a b) = 1
        abs (Zespolone a b) = 0
        fromInteger a = (Zespolone (a) 0)
 
instance Show Zespolone
    where
        show (Zespolone a b) = 
                show a ++ "+" ++ show b ++ "i"

{-
ZADANIE 6
Zdefiniować typ odpowiadający macierzom 2x2 o współczynnikach
całkowitych, zaimplementować dodawanie, mnożenie i wypisywanie
macierzy (wypisywanie w możliwie czytelny sposób)
-}

data Matrix = Matrix {
a1 :: Integer,
a2 :: Integer,
a3 :: Integer,
a4 :: Integer
}

instance Show Matrix
    where
    show (Matrix a b c d) =
        show a ++ " " ++ show b ++ "\n" ++ show c ++ " " ++ show d ++ "\n"
        
add :: Matrix -> Matrix -> Matrix
add (Matrix a b c d) (Matrix e f g h) = Matrix {a1=a+e, a2=b+f, a3=c+g, a4=d+h}

mult :: Matrix -> Matrix -> Matrix
mult (Matrix a b c d) (Matrix e f g h) = Matrix {a1=a*e + b*g, a2=a*f + b*h, a3=c*e + d*g, a4=c*f + d*h}

-- mat1 = Matrix{a1 = 1, a2 = 2, a3 = 3, a4 = 4}
-- mat2 = Matrix{a1 = 3, a2 = 4, a3 = 5, a4 = 6}

-- add mat1 mat2
-- mult mat1 mat2
