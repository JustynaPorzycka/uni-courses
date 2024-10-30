import System.IO;
import System.Environment;

type Square = (Int, Int) -- representation of coordinates of one square
type Polyomino = [Square] 


-- Helper functions for shiftRelativeTo (adding, subtracting coordinates)
addCrd :: Square -> Square -> Square
addCrd square1 square2 = (fst square1 + fst square2, snd square1 + snd square2)

subCrd :: Square -> Square -> Square
subCrd square1 square2 = (fst square1 - fst square2, snd square1 - snd square2)

-- We shift the coordinates of the squares of a given polyomino relative to the selected square
shiftRelativeTo :: Square -> Polyomino -> Polyomino
shiftRelativeTo squareToHook poly = map (\square -> addCrd square (subCrd squareToHook (head poly))) poly

-- We check whether all squares (coordinates) of one polyomino are present in the second one,
-- in other words if one can be put into the other
match :: Polyomino -> Polyomino -> Bool
match poly1 poly2 = all (\square -> square `elem` poly2) poly1

-- We go successively through the squares of the area to be covered. If a polyomino shifted relative to the 
-- selected square can be 'inserted' into the area to be covered, then we add this square to the set of squares 
-- in which we can 'hook'. Finally, we return this set
findSquaresToHook :: Polyomino -> Polyomino -> [Square]
findSquaresToHook areaToCover poly = foldl(\found squareToHook -> if (match (shiftRelativeTo squareToHook poly) areaToCover) then squareToHook : found else found) 
                                     [] areaToCover

-- Remove given polyomino from the given area
remove :: Polyomino -> Polyomino -> Polyomino
remove poly areaToCover = foldl(\area square -> filter (/= square) area) areaToCover poly

-- We return all combination of given polyominos, such that the total number of squares of those polyominos
-- is equal to a given number
possibleCandidates :: [Polyomino] -> Int -> [[Polyomino]]
possibleCandidates _ 0 = []
possibleCandidates (p:ps) n | length p > n  = possibleCandidates ps n
                            | length p == n = [p]:(possibleCandidates ps n)
                            | length p < n  =  [p:ys | ys <- possibleCandidates (p:ps) (n-(length p))] ++ (possibleCandidates ps n)
possibleCandidates _ _ = []

-- We generate all the squares in which we can 'hook', so that the polyomino fits in the area. We take the first 
-- such square. We remove the polyomino from the place in the region where we 'hooked' and repeat the procedure 
-- for the rest of the polyominoes in the given set. If we get to two empty lists, it means that it was possible
-- to cover the entire area with all given polyomines. If not, we take another square from the first polyomino
-- and repeat the procedure, 'hook' in the square and remove polyomino from another place, etc. If in any step 
-- we get two empty lists, we return True, if we don't get empty lists at any time and the squares in which we 
-- can 'hook' the first polyomino run out, we return False.
isPossibleToCover' :: Polyomino -> [Polyomino] -> Bool
isPossibleToCover' [] []              = True
isPossibleToCover' [] _polySet        = False
isPossibleToCover' _areaToCover []    = False
isPossibleToCover' areaToCover (p:ps) = any (\squareToHook -> isPossibleToCover' (remove (shiftRelativeTo squareToHook p) areaToCover) ps) 
                                        (findSquaresToHook areaToCover p)

-- We take a set of polyominos and area to cover, create a list of all possible *candidates and check whether
-- there is any candidate such that it is possible to cover the area by using its elements
-- * candidate is a list of polyominos from polySet such that the total number of squares of those polyominos
-- is equal to the number of squares in the area to cover
isPossibleToCover :: Polyomino -> [Polyomino] -> Bool
isPossibleToCover areaToCover polySet = any (\candidates -> isPossibleToCover' areaToCover candidates) 
                                        (possibleCandidates polySet (length areaToCover))

--------------------------------------------------------------------------------------------------------------

-- Converts string to a list of ints
strToIntList :: String -> [Int]
strToIntList str = map (\el -> read el :: Int) (foldl(\acc char -> if elem char [',',' '] then acc ++ [[]] 
                                                else init acc ++ [last acc ++ [char]]) [[]] str)                               

-- Converts a list of ints to list of squares which define polyomino
intsToPoly :: [Int] -> Polyomino
intsToPoly (x:y:rest) = (x,y) : intsToPoly rest
intsToPoly _          = []

-- Converts string representation of polyomino to type Polyomino
toList :: [String] -> [Polyomino]
toList = foldl(\acc strPoly -> intsToPoly (strToIntList strPoly) : acc) [] 

-- Reads file, converts string representation of polyominos from file to actual
-- polyominos, extracts the polyomino (areaToCover) to be arranged and the rest.
-- Returns whether it is possible to cover the area
main :: IO ()        
main = do
        putStrLn "Podaj nazwe pliku:"
        fileName <- getLine
        fileContent <- readFile fileName
        let allPolyos = toList (lines fileContent)
        let areaToCover = last allPolyos
        let setOfPolyos = init allPolyos
        print (isPossibleToCover areaToCover setOfPolyos)
        main