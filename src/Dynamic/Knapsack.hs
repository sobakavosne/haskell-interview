{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs               #-}

module Dynamic.Knapsack where

import           Data.List (subsequences)

-- NP-complete problem in combinatorial optimization
-- https://en.wikipedia.org/wiki/Knapsack_problem
--
newtype Size =
  Size Int
  deriving (Eq, Ord, Num)

newtype Value =
  Value Int
  deriving (Eq, Ord, Num)

newtype List a =
  List [a]

type Name = String

data Item =
  Item
    { name     :: Name
    , itemSize :: Size
    , value    :: Value
    }

instance Show a => Show (List a) where
  show :: Show a => List a -> String
  show (List xs) = "[ " ++ go xs
    where
      go []     = "]"
      go [x]    = show x ++ "\n]"
      go (x:xs) = show x ++ "\n, " ++ go xs

instance Show Size where
  show :: Size -> String
  show (Size x) = show x ++ "kg"

instance Show Value where
  show :: Value -> String
  show (Value x) = show x ++ "$"

instance Show Item where
  show :: Item -> String
  show (Item name itemSize value) =
    show name ++ " " ++ show itemSize ++ " " ++ show value

instance Eq Item where
  (==) (Item _ sizeX _) (Item _ sizeY _) = sizeX == sizeY
  (/=) x y = not (x == y)

instance Ord Item where
  (<) (Item _ sizeX _) (Item _ sizeY _) = sizeX < sizeY
  (<=) (Item _ sizeX _) (Item _ sizeY _) = sizeX <= sizeY
  (>) (Item _ sizeX _) (Item _ sizeY _) = sizeX > sizeY
  (>=) (Item _ sizeX _) (Item _ sizeY _) = sizeX >= sizeY
  -- max = _
  -- min = _

data Knapsack =
  Knapsack
    { items        :: [Item]
    , knapsackSize :: Size
    }

instance Show Knapsack where
  show :: Knapsack -> String
  show (Knapsack elems size) =
    "Knapsack size: " ++ show size ++ "\nElements: " ++ show elems

_items :: List Item
_items =
  List
    [ Item "Guitar" (Size 1) (Value 1500)
    , Item "Computer" (Size 3) (Value 2000)
    , Item "Record Player" (Size 4) (Value 3000)
    , Item "Phone" (Size 1) (Value 2500)
    ]

_knapsack :: Knapsack
_knapsack = Knapsack [] $ Size 4

-- | Brutto solution
-- mostValueableButStupid :: [Item] -> Knapsack -> [a]
-- mostValueableButStupid (List items) (Knapsack _ (Size size)) =
--   [x | x <- subsequences items, foldl1 (+) x <= 4]
--
-- | Dynamic solution
mostValueable :: Knapsack
mostValueable = undefined
--
--- $> mostValueableButStupid _items _knapsack
--
-- $> _items
