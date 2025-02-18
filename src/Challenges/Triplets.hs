{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Challenges.Triplets where

import           Data.List (sort)
import           Data.Set  (fromList, toList)

-- findTriplet :: (Eq c, Num c) => [c] -> [(c, c, c)]
-- findTriplet l@[x, y, z] = bool [] [(x, y, z)] (sum l == 0)
-- findTriplet (x:y:zs)    = [(x, y, z) | z <- zs, sum [x, y, z] == 0]
-- findTriplets :: (Num a, Ord a) => [a] -> [(a, a, a)]
-- findTriplets nums = go (sort nums)
--   where
--     go l@[x, y, z] = findTriplet l
--     go l           = findTriplet l ++ (go . tail) l
--
-- | Find all triplets with zero sum
findTriplets :: [Integer] -> [[Integer]]
findTriplets = undefined

-- | Find all zero sum triplets for current number
findTripletsForNum :: [Integer] -> [[Integer]]
findTripletsForNum = toList . fromList . map sort . findTriplet . sort
  where
    findTriplet (x:ys) =
      [ [x, y, z]
      | y <- ys
      , x /= y
      , z <- tail ys
      , y /= z
      , x /= z
      , sum [x, y, z] == 0
      ]
--
-- $> findTripletsForNum [1,-4,3,0,-3, 5, 4, -2, 12, 2, 6]
--
-- the answer:
--
-- [ [-4, -2, 6]
-- , [-4, 0, 4]
-- , [-4, 1, 3]
-- , [-3, -2, 5]
-- , [-3, 0, 3]
-- , [-3, 1, 2]
-- , [-2, 0, 2]
-- ]
