module Challenges.AlexaReplica
  ( isCompound
  ) where

import           Data.Bool (bool)
import           Data.List (isPrefixOf)

isCompound' :: String -> [String] -> Bool
isCompound' [] _ = True
isCompound' _ [] = False
isCompound' word (x:xs) =
  bool
    (isCompound word xs)
    (isCompound (drop (length x) word) xs)
    (x `isPrefixOf` word)

-- Idiomatic solution
isCompound :: String -> [String] -> Bool
isCompound [] _ = True
isCompound _ [] = False
isCompound word (x:xs) =
  (x `isPrefixOf` word && isCompound (drop (length x) word) xs)
    || isCompound word xs
--
-- $> isCompound "wateroflove" ["water", "means", "every", "drop", "of", "love"]
