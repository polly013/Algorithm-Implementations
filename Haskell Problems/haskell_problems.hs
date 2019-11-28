------------------- Random problem  ----------------------
helper :: (Num b, Eq b) => [a] -> b -> b -> a
helper (x:xs) k n = if k == n then x
                    else helper xs (k+1) n

msize :: (Integral a) => [a] -> a -> a
msize [] n = n
msize (x:xs) n = msize xs (n+1)

mid :: (Integral a) => [a] -> a
mid [x] = x
mid x
    | odd n = helper x 0 n
    | otherwise = error "even number of elements"
    where n = (msize x 0) `div` 2
---------------------------------------------------------
----------------------- Week 1 --------------------------
sum2 :: (Num a) => a -> a -> a
sum2 x y = x + y

fib :: (Integral a) => a -> a
fib 1 = 0
fib 2 = 1
fib n = fib (n-1) + fib (n-2)

fact :: (Integral a) => a -> a
fact 0 = 1
fact n = n * fact (n-1)

length1 :: (Num a) => [a] -> a
length1 [] = 0
length1 (x:xs) = 1 + length1(xs)

first :: (a,b,c) -> a
first (x,_,_) = x

maxElement :: (Ord a) => [a] -> a
maxElement [] = error "Empty list"
maxElement (x:[]) = x
maxElement (x:xs)
  | x < rx = rx
  | otherwise = x
  where rx = maxElement (xs)

myReverse :: (Num a) => [a] -> [a]
myReverse [] = error "Empty list"
myReverse (x:[]) = [x]
myReverse (x:xs) = myReverse(xs) ++ [x]

member :: (Integral a) => ([a],a) -> Bool
member ([], _) = False
member (x:xs, n)
  | x == n = True
  | otherwise = member (xs, n)

---------------------------------------------------------
----------------------- Week 2 --------------------------
getAllTuples :: [Int] -> [(Int, Int)]
getAllTuples xs = [(x, y) | x<-xs, y<-xs]

getAllTuples1 :: [Int] -> [(Int, Int)]
getAllTuples1 [] = []
getAllTuples1 (x:xs) = [(x, y) | y <-xs] ++ getAllTuples1 (xs)

isRightTriangle :: [Double] -> [(Double, Double, Double)]
isRightTriangle xs = [(x,y,z) | x<-xs, y<-xs, z<-xs, x*x + y*y == z*z, x <= y]

myDrop :: [a] -> Int -> [a]
myDrop [] _ = []
myDrop xs 0 = xs
myDrop (x:xs) n = myDrop xs (n-1)

myZip :: [a] -> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

sumElems :: (Num a) => [a] -> a
sumElems [] = 0
sumElems (x:xs) = x + sumElems xs

isSorted :: (Ord a) => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs)
  | x <= y = isSorted(y:xs)
  | otherwise = False

---------------------------------------------------------
----------------------- Week 3 --------------------------

append :: [a] -> [a] -> [a]
append x y = x ++ y

append1 :: [a] -> [a] -> [a]
append1 [] y = y
append1 (x:xs) y = x : (append1 xs y)

-- myFlatten :: [[a]] -> [a]
-- myFlatten [] = []
-- myFlatten (x:xs) = append x (myFlatten xs)

myTrim :: [a] -> Int -> [a]
myTrim [] _ = []
myTrim xs 0 = []
myTrim (x:xs) n = x : myTrim xs (n-1)

mySlice :: [a] -> Int -> Int -> [a]
mySlice [] _ _ = []
mySlice x n m = myTrim (myDrop x n ) (m-1)

countOccurances :: (Eq a) => [a] -> a -> Int
countOccurances [] _ = 0
countOccurances (x:xs) n
  | x == n = 1 + countOccurances xs n
  | otherwise = countOccurances xs n

remove :: (Eq a) => [a] -> a -> [a]
remove [] _ = []
remove (x:xs) n
  | x == n = remove xs n
  | otherwise = x : remove xs n

divisors :: Int -> [Int]
divisors x = [d | d <- [1..x], mod x d == 0]

-- lame
prime :: Int -> Bool
prime x
  | divisors x == [1, x] = True
  | otherwise = False

endsWith :: Int -> Int -> Bool
endsWith _ 0 = True
endsWith 0 n = False
endsWith xn n
  | (mod xn 10) == (mod n 10) = endsWith (div xn 10) (div n 10)
  | otherwise = False

---------------------------------------------------------
----------------------- Week 4 --------------------------
myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = (f x) : (myMap f xs)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f [] = []
myFilter f (x:xs)
  | f x = x : (myFilter f xs)
  | otherwise = myFilter f xs

myFoldr :: (a -> a -> a) -> a -> [a] -> a
myFoldr f beg [] = beg
myFoldr f beg (x:xs) = f x (myFoldr f beg xs)

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (x:xs) (y:ys) = (f x y) : (myZipWith f xs ys)

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile f (x:xs)
  | f x = x : (myTakeWhile f xs)
  | otherwise = []

myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile _ [] = []
myDropWhile f (x:xs)
  | f x = myDropWhile f xs
  | otherwise = x:xs

squareAndDouble :: (Num a) => [a] -> a
squareAndDouble [] = 0
squareAndDouble (x:xs) = x * x * 2 + squareAndDouble xs

---------------------------------------------------------
---------------- Recap of Quick Sort  -------------------
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
  let smaller = quickSort [a | a <- xs, a <= x]
      bigger = quickSort [b | b <- xs, b > x]
  in smaller ++ [x] ++  bigger
