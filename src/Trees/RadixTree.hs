module Trees.RadixTree where

import           Data.List (stripPrefix)

data RadixTree
  = Leaf
  | Node Char [(String, RadixTree)]
  deriving (Show)

-- Insert a string into the radix tree
insert :: String -> RadixTree -> RadixTree
insert [] tree = tree
insert str Leaf = Node '\0' [(str, Leaf)]
insert str (Node c children) =
  let (prefix, suffix) = splitPrefix str (map fst children)
   in if null prefix
        then Node c ((str, Leaf) : children)
        else Node c (map (update prefix suffix) children)

-- Search for a string in the radix tree
search :: String -> RadixTree -> Bool
search [] Leaf = True
search str Leaf = False
search str (Node c children) =
  let (prefix, suffix) = splitPrefix str (map fst children)
   in (null prefix && any (search suffix . snd) children)

-- Split a string into a prefix and a suffix, given a list of strings to match against
splitPrefix :: String -> [String] -> (String, String)
splitPrefix str [] = ([], str)
splitPrefix str (x:xs) =
  case stripPrefix x str of
    Just suffix -> (x, suffix)
    Nothing ->
      let (prefix, suffix) = splitPrefix str xs
       in (prefix, suffix)

-- Update a child node's string and radix tree with a prefix and suffix
update :: String -> String -> (String, RadixTree) -> (String, RadixTree)
update prefix suffix (str, tree) =
  (drop (length prefix) str, insert suffix tree)

tree :: RadixTree
tree = insert "hello" Leaf

tree' :: RadixTree
tree' = insert "world" tree
--
-- $> search "hello" tree'
