
import System.Random

main = do 
  contents <- readFile "languages.txt"
  num <- randomIO :: IO Float
  let idx = floor $ num * (fromIntegral (length ( words contents)))
  print $ (words contents)!!idx
