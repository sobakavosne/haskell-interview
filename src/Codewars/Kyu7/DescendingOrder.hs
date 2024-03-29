module Codewars.Kyu7.DescendingOrder where

import           Data.List (sortOn)
import           Data.Ord  (Down (Down))

-- Your task is to make a function that can take
-- any non-negative integer as an argument and
-- return it with its digits in descending order.
-- Essentially, rearrange the digits to create the
-- highest possible number.
-- Examples:
--
-- Input: 42145 Output: 54421
--
-- Input: 145263 Output: 654321
--
-- Input: 123456789 Output: 987654321
--
descendingOrder :: Integer -> Integer
descendingOrder = read . sortOn Down . show
-- descendingOrder = read . sortBy (flip compare) . show
--
-- $> descendingOrder 127033191
