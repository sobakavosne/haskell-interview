module Challenges.Alexa where

import           Data.List       (insert, isPrefixOf)
import qualified Data.SuffixTree as SufT
import           Prelude         hiding (elem)

-- foobar
-- barfoo
--
-- [foo, bar, fizz, fir, fi, iop]
-- bar
-- splitAt () ws
--  [x | x <- ws, isPrefixOf x w]
findMatch :: Eq a => [a] -> [[a]] -> [[a]]
findMatch w ws = [x | x <- ws, x `isPrefixOf` w]

-- print $ (++) <$> ["a", "b", "c"] <*> ["x", "y"]
removeMatch :: Foldable t => t a1 -> [a2] -> [a2]
removeMatch m = drop (length m)

dictionary :: [String]
dictionary = ["foo", "bar", "fizz", "fir", "fi", "iop"]

-- $> removeMatch "foo" "foobar"
--
----------------------------------------------------------------
-- Function that checks whether string s can be constructed from words in the list
canConstruct :: String -> [String] -> Bool
canConstruct word words = go word
  where
    go [] = True -- If the string is empty, it can be constructed
    go str =
      any
        (\word -> (word `isPrefixOf` str) && go (drop (length word) str))
        words

wordList :: [String]
wordList = ["Foo", "Bar", "Car", "Bob", "Sirius"]

inputWord :: String
inputWord = "FooBarSirius"
--
-- $> canConstruct inputWord wordList
--
----------------------------------------------------------------
-- isCompaund :: String -> SufT.STree -> Bool
-- isCompaund :: String -> [String] -> Bool
-- isCompaund word xs = word `SufT.elem` tree
--
-- tree = SufT.construct ["Key", "Word", "Insert"]
--
--- $> isCompaund "Key" ["Key", "Word", "Insert"]
