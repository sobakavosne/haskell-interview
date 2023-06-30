module Codewars.BreakCamelCase where

import           Data.Char (isLower, isUpper)

-- Complete the solution so that the function will break up
-- camel casing, using a space between words.
--
-- Example
--
-- "camelCasing"  =>  "camel Casing"
-- "identifier"   =>  "identifier"
-- ""             =>  ""
--
solution :: String -> String
solution [] = ""
solution [x1] = [x1]
solution (x1:x2:xs)
  | isLower x1 && isUpper x2 = x1 : ' ' : x2 : solution xs
  | otherwise = x1 : solution (x2 : xs)
--
-- $> solution "Zedzweok"

-- ["Vcyshwfg","Yxsday","Zedzweok","Alk","Xwn","J","Dyb"]