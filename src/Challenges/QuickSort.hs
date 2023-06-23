module Challenges.QuickSort where

-- | 'QuickSort' algorythm implementation
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (p:xs) = quicksort lesser ++ [p] ++ quicksort greater
  where
    lesser = filter (< p) xs
    greater = filter (>= p) xs
--
-- $> quicksort [1,2,7,0,15,1,1]
