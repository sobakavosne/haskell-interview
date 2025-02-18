module Challenges.Alexa where

import           Data.List (isPrefixOf)

-- import qualified Data.SuffixTree as SufT
import           Prelude   hiding (elem)

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
canConstruct word' xs = go word'
  where
    go []   = True -- If the string is empty, it can be constructed
    go word = any (\x -> (x `isPrefixOf` word) && go (drop (length x) word)) xs

wordList :: [String]
wordList = ["Foo", "Bar", "Car", "Bob", "Sirius"]

inputWord :: String
inputWord = "FooBarSirius"
--
-- $> canConstruct inputWord wordList
--
----------------------------------------------------------------
-- isCompound :: String -> SufT.STree -> Bool
-- isCompound :: String -> [String] -> Bool
-- isCompound word xs = word `SufT.elem` tree
--
-- tree = SufT.construct ["Key", "Word", "Insert"]
--
--- $> isCompound "Key" ["Key", "Word", "Insert"]
