module AlexaChallenge where

import           Data.List (isPrefixOf)

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
