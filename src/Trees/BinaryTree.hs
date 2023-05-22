{-# LANGUAGE InstanceSigs #-}

module Trees.BinaryTree where

import           Data.List (sort)

data BinaryTree a
  = Leaf
  | Node a (BinaryTree a) (BinaryTree a)
  deriving (Show, Eq)

data BinaryTreeWithIndex a
  = Empty
  | NodeWithIndex (BinaryTreeWithIndex a) a (BinaryTreeWithIndex a)

spaces :: Int -> String
spaces n = map (const ' ') [1 .. n]

showsTree :: Show a => Int -> BinaryTreeWithIndex a -> String -> String
showsTree i Empty = showString (spaces i) . showString "Empty\n"
showsTree i (NodeWithIndex a n c) =
  showString (spaces i) .
  ('(' :) .
  shows n .
  ('\n' :) .
  showsTree (i + 3) a .
  showsTree (i + 3) c . showString (spaces i) . showString ")\n"

binaryTreeSearch :: Ord a => a -> BinaryTreeWithIndex a -> Maybe a
binaryTreeSearch _ Empty = Nothing
binaryTreeSearch x (NodeWithIndex left a right)
  | x < a = binaryTreeSearch x left
  | x > a = binaryTreeSearch x right
  | otherwise = Just a

instance Show a => Show (BinaryTreeWithIndex a) where
  showsPrec :: Show a => Int -> BinaryTreeWithIndex a -> ShowS
  showsPrec _ = showsTree 0

optTree :: [(Int, String)] -> BinaryTreeWithIndex (Int, String)
optTree = optTreeR . sort

optTreeR :: [(Int, String)] -> BinaryTreeWithIndex (Int, String)
optTreeR [] = Empty
optTreeR s = NodeWithIndex (optTreeR first) node (optTreeR rest)
  where
    (first, node:rest) = splitAt (length s `div` 2) s

treeWithIndex :: BinaryTreeWithIndex (Int, String)
treeWithIndex =
  optTree
    [ (1, "A")
    , (2, "B")
    , (3, "C")
    , (4, "D")
    , (5, "E")
    , (6, "F")
    , (7, "G")
    , (8, "H")
    , (9, "I")
    ]

main :: IO ()
main = print $ take 10 fib

fib0 :: [Integer]
fib0 = 0 : fib

fib1 :: [Integer]
fib1 = zipWith (+) fib fib0

fib :: [Integer]
fib = 1 : fib1
--
-- $> treeWithIndex
