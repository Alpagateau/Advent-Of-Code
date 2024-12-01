import Data.List

readInt :: String -> Int
readInt = read

split :: [Int] -> ([Int], [Int]) -> ([Int], [Int])
split [] _ = ([], [])
split (x:y:xs) s = (x:a, y:b)
  where (a, b) = split xs s

dsort :: ([Int], [Int]) -> ([Int], [Int])
dsort (a, b) = (sort a, sort b)

dist :: ([Int], [Int]) -> Int
dist ([], []) = 0
dist ((x:xs), (y:ys)) = (abs (y-x)) + (dist (xs, ys))

count :: [Int] -> Int -> Int
count [] _ = 0
count (x:xs) t | t == x = 1 + (count xs t) 
               | otherwise = count xs t

simScore :: ([Int], [Int]) -> Int
simScore ([], _) = 0
simScore ((x:xs), a) = x * (count a x) + simScore (xs, a)


main = do 
  contents <- readFile "input.txt"
  let l = map readInt . words $ contents
  let (a, b) = dsort ( split l ([], []) )
  -- Part One --
  --print (a, b)
  print $ dist (a, b)
  
  -- Part Two --
  print $ simScore (a, b)
  

