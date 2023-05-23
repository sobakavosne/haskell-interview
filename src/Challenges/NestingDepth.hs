module Challenges.NestingDepth where

-- Problem Link (Contest):  https://leetcode.com/contest/weekly-contest-210/problems/maximum-nesting-depth-of-the-parentheses/
-- Problem Link (Practice): https://leetcode.com/problems/maximum-nesting-depth-of-the-parentheses/

maxDepth :: String -> Int
maxDepth = maximum
         . scanl1 (+)
         . map (\ c -> if c == '(' then 1 else -1)
         . filter (`elem` ['(',')'])

-- $> maxDepth "(1 + (3 / (10 - 5)))"
