module Codewars.Kyu6.HighestScoringWord where

import           Data.List  (maximumBy, sortOn)
import           Data.Maybe (fromJust)

-- Given a string of words, you need to find
-- the highest scoring word. Each letter of a
-- word scores points according to its position
-- in the alphabet: a = 1, b = 2, c = 3 etc.
-- For example, the score of abad is 8 (1 + 2 + 1 + 4).
--
-- You need to return the highest scoring word as a string.
--
-- If two words score the same, return the word that
-- appears earliest in the original string.
--
-- All letters will be lowercase and all inputs will be valid.
--
high :: String -> String
high = desypher . snd . maximumBySum . zip [1 ..] . sypher . words
  where
    sumOfSnd = sum . map read . snd
    maximumBySum =
      maximumBy
        (\a b ->
           case compare (sumOfSnd a) (sumOfSnd b) of
             EQ    -> compare (fst b) (fst a)
             other -> other)
    alphabet = zip ['a' .. 'z'] [1 .. 26]
    sypher = map $ map (show . fromJust . (`lookup` alphabet))
    desypher = map $ fromJust . (`lookup` [(k, v) | (v, k) <- alphabet]) . read
--
-- $> high "b aa"
