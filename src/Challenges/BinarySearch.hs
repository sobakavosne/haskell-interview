module Challenges.BinarySearch where

import qualified GHC.Base as B

binarySearch :: Ord a => [a] -> a -> Maybe a
binarySearch l@(x:xs) item
  | item `notElem` l = Nothing
  | otherwise = (binarySplit . splitAt (B.divInt (length l) 2)) l
  where
    binarySplit (y:ys, z:zs)
      | z > item = binarySearch (y : ys) item
      | z < item = binarySearch zs item
      | otherwise = Just item
--
-- $> binarySearch [1, 2, 3, 4, 5, 9, 10] 8
