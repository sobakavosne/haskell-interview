module Codewars.BreakCamelCase where

import           Data.Char   (isUpper)
import           GHC.Unicode (isAlpha)

-- Complete the solution so that the function will break up
-- camel casing, using a space between words.
--
-- Example
--
-- "camelCasing"  =>  "camel Casing"
-- "identifier"   =>  "identifier"
-- ""             =>  ""
--
cases :: [String]
cases = ["VcyVVshwfgV", "Yxsday", "Zedzweok", "Alk", "Xwn", "J", "Dyb"]

solution :: String -> String
solution [] = ""
solution [x1] = [x1]
solution (x:xs)
  | isAlpha x && (isUpper . head) xs = x : ' ' : solution xs
  | otherwise = x : solution xs
--
-- $> map solution cases
--
