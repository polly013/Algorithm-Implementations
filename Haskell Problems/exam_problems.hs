----------------------------------------------------------------
-------- 1. All boolean functions with N parameters  -----------

booleanFunctions :: Int -> [[Bool]]
booleanFunctions 0 = [[]]
booleanFunctions n = [ state : previous | state <- [True, False], previous <- booleanFunctions (n-1)]

----------------------------------------------------------------
----------- 2. Filter with an array of functions  --------------

myFilterAndMap :: [a -> Bool] -> [a] -> [a]
myFilterAndMap [] xs = xs
myFilterAndMap (f:fs) xs = myFilterAndMap fs (filter f xs)

----------------------------------------------------------------
---------------------- 3. Suffix check -------------------------

isSuffix :: (Eq a) => [a] -> [a] -> Bool
isSuffix _ [] = True
isSuffix [] _ = False
isSuffix xs ys
  | last xs == last ys = isSuffix (init xs) (init ys)
  | otherwise = False

----------------------------------------------------------------
--------- 4. Functions for permutations and variations ---------

without :: (Eq a) => [a] -> a -> [a]
without xs x = filter (/= x) xs

perm :: (Eq a) => [a] -> [[a]]
perm [] = [[]]
perm xs = [x:rest | x <- xs, rest <- perm (xs `without` x)]

-- perm xs = var xs (length xs)

var :: Eq a => [a] -> Int -> [[a]]
var [] _ = [[]]
var _ 0 = [[]]
var xs k = [x:rest | x <- xs, rest <- var (xs `without` x) (k-1)]

----------------------------------------------------------------
------------ 5. Count occurances in a multiset  ----------------

multiset :: (Eq a) => [a] -> [(a, Int)]
multiset [] = []
multiset (x:xs) = (x, count x) : multiset (without xs x)
  where count y = length (filter (== y) (x:xs))

specialFilter :: (Ord a) => (Int -> Bool) -> [a] -> [a]
specialFilter _ [] = []
specialFilter f (x:xs)
  | f (count x) = x : specialFilter f (without xs x)
  | otherwise = specialFilter f (without xs x)
  where count y = length (filter (== y) (x:xs))
