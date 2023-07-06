module Challenges.Median where

median :: Integral a => [a] -> [a] -> a
median a b = findMedian (merge a b)
  where
    divSplited (x, y) = last x + head y `div` 2
    findMedian xs
      | (odd . length) xs = (!! max 0 (length xs `div` 2)) xs
      | otherwise = (divSplited . splitAt (length xs `div` 2)) xs
    merge xs [] = xs
    merge [] ys = ys
    merge l1@(x:xs) l2@(y:ys)
      | x < y = x : merge xs l2
      | otherwise = y : merge l1 ys
--
-- $> median [1, 12, 15, 26, 38] [2, 13, 17, 30, 45]
