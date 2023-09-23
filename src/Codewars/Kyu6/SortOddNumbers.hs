module Codewars.Kyu6.SortOddNumbers where

import           Data.List  (sortOn)
import           Data.Maybe (fromMaybe)

-- You will be given an array of numbers.
-- You have to sort the odd numbers in ascending
-- order while leaving the even numbers at their
-- original positions.
--
-- Examples
--
-- [7, 1]  =>  [1, 7]
-- [5, 8, 6, 3, 4]  =>  [3, 8, 6, 5, 4]
-- [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]  =>  [1, 8, 3, 6, 5, 4, 7, 2, 9, 0]
--
sortArray :: [Int] -> [Int]
sortArray l = (merge enumerated . sortOn snd . filter (odd . snd)) enumerated
  where
    enumerated = zip [0 .. length l] l
    merge xs [] = map snd xs
    merge [] ys = map snd ys
    merge (x:xs) (y:ys)
      | even (snd x) = snd x : merge xs (y : ys)
      | otherwise = snd y : merge xs ys
--
-- $> sortArray [19, 18, 17, 16, 15, 14, 13, 12, 11, 0]
