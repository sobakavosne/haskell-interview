module Challenges.TernarySearch where

import           Data.List (sort)

ternarySearch :: Ord a => [a] -> a -> Maybe a
ternarySearch l@(x:xs) item
  | x > item || last xs < item = Nothing
  | otherwise = (triplet . ternary . sort) l
  where
    ternary xs = (binary . splitAt (length xs `div` 3)) xs
    binary (ys, zs) = (ys, splitAt (length zs `div` 2) zs)
    triplet t =
      case t of
        (a:as, (b:bs, c:cs))
          | c < item -> ternarySearch cs item
          | b < item -> ternarySearch bs item
          | a < item -> ternarySearch as item
        ([], (b:bs, c:cs))
          | c < item -> ternarySearch cs item
          | b < item -> ternarySearch bs item
        (a:as, ([], c:cs))
          | c < item -> ternarySearch cs item
          | a < item -> ternarySearch as item
        (a:as, (b:bs, []))
          | b < item -> ternarySearch bs item
          | a < item -> ternarySearch as item
        _ -> Just item
--
-- $> ternarySearch [1..100] 10
