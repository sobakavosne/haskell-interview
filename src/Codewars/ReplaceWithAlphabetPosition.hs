module Codewars.ReplaceWithAlphabetPosition where

import           Data.Char  (isAlpha, isLatin1, toLower)
import           Data.Maybe (fromMaybe)

-- In this kata you are required to, given a string,
-- replace every letter with its position in the alphabet.
-- If anything in the text isn't a letter, ignore it and
-- don't return it.
-- "a" = 1, "b" = 2, etc.
--
-- Example
--
-- alphabetPosition "The sunset sets at twelve o' clock."
-- Should return "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11" ( as a string )
--
alphabetPosition :: String -> String
alphabetPosition = unwords . map unpackLookup . filter isLatin1
  where
    alphabet = zip ['a' .. 'z'] $ map show [1 .. 26]
    unpackLookup = fromMaybe "" . flip lookup alphabet . toLower
--
-- $> alphabetPosition "\629256\163013\197968\1074005\487532\202384\22980\104889\281495"
