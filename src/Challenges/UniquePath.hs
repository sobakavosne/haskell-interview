module Challenges.UniquePath where

-- https://www.youtube.com/watch?v=GhiRlhPlJ9Q
--
-- Dynamic programming
--
-- Robot - ○○
-- Exit  - ●●
-- Google task: Find all the ways leading to the exit (from ○○ to ●●).
-- The robot can only move up or right.
--
-- ┌────┬────┬────┬────┬────┐
-- │    │    │    │    │ ●● │
-- ├────┼────┼────┼────┼────┤
-- │    │    │    │    │    │
-- ├────┼────┼────┼────┼────┤
-- │    │    │    │    │    │
-- ├────┼────┼────┼────┼────┤
-- │ ○○ │    │    │    │    │
-- └────┴────┴────┴────┴────┘
-- n = 5, m = 4
--
paths :: Int -> Int -> Int
paths n m =
  case (n, m) of
    (_, 0) -> 0
    (0, _) -> 0
    (1, 1) -> 1
    (n, m) -> paths (n - 1) m + paths n (m - 1)
--
-- $> paths 5 4
