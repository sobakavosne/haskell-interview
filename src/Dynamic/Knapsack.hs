{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs               #-}

module Dynamic.Knapsack where

import           Data.Foldable (Foldable (..), maximumBy)
import           Data.Function (on)
import           Data.List     (subsequences)

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

data Knapsack =
  Knapsack
    { knapsackSize :: Size
    , items        :: [Item]
    }

instance Show Knapsack where
  show :: Knapsack -> String
  show (Knapsack size elems) =
    "Knapsack size: " ++ show size ++ "\nElements: " ++ show elems

_items :: List Item
_items =
  List
    [ Item "Guitar" (Size 1) (Value 1500)
    , Item "Phone" (Size 2) (Value 2500)
    , Item "Brown fox" (Size 1) (Value 1000)
    , Item "Brown fox" (Size 1) (Value 500)
    ]

-- | Brutto solution
mostValueableButStupid :: List Item -> Int -> Knapsack
mostValueableButStupid (List items) size =
  Knapsack (Size size) $
  maximumBy
    (compare `on` sum . map value)
    [ x
    | x <- subsequences items
    , foldl (\acc (Item x (Size s) z) -> acc + s) 0 x <= size
    ]

-- | Dynamic solution
mostValueable :: Knapsack
mostValueable = undefined
--
-- $> mostValueableButStupid _items 4
