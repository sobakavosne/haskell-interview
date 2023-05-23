module Challenges.NestingDepth where

-- YouTube Link (Comparing): https://www.youtube.com/watch?v=zrOIQEN3Wkk
-- Problem Link (Contest):  https://leetcode.com/contest/weekly-contest-210/problems/maximum-nesting-depth-of-the-parentheses/
-- Problem Link (Practice): https://leetcode.com/problems/maximum-nesting-depth-of-the-parentheses/

maxDepth :: String -> Int
maxDepth = maximum
         . scanl1 (+)
         . map (\ c -> if c == '(' then 1 else -1)
         . filter (`elem` ['(',')'])

-- $> maxDepth "(1 + (10 - 5 (10 (10 - 5) - 5)) (3 / (10 - 5)))"
