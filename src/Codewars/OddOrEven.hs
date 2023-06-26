module Codewars.OddOrEven where

import           Data.Bool (bool)

-- Task:
-- Given a list of integers, determine whether the sum
-- of its elements is odd or even.
-- Give your answer as a string matching "odd" or "even".
--
oddOrEven :: Integral a => [a] -> String
oddOrEven = bool "odd" "even" . even . sum
--
-- $> oddOrEven [0, 1, 4]
