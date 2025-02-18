{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Challenges.BinarySearch where

import qualified GHC.Base as B

binarySearch :: Ord a => [a] -> a -> Maybe a
binarySearch l item
  | item `notElem` l = Nothing
  | otherwise = (binarySplit . splitAt (B.divInt (length l) 2)) l
  where
    binarySplit ([], zs) = binarySearch zs item
    binarySplit (y:ys, z:zs)
      | z > item = binarySearch (y : ys) item
      | z < item = binarySearch zs item
      | otherwise = Just item

binarySearch' :: Ord a => [a] -> a -> Maybe a
binarySearch' [] _ = Nothing
binarySearch' l item =
  let mid = length l `div` 2
      (left, right) = splitAt mid l
      middle = head right
   in if middle == item
        then Just item
        else if item < middle
               then binarySearch left item
               else binarySearch right item
--
-- $> binarySearch [2, 3, 4, 5, 9, 10] 2
