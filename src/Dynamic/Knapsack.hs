{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs               #-}

module Dynamic.Knapsack where

import           Data.Foldable (maximumBy)
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
    { name   :: Name
    , iSize  :: Size
    , iValue :: Value
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
  show (Item name size value) =
    show name ++ " " ++ show size ++ " " ++ show value

data Knapsack =
  Knapsack
    { kSize  :: Size
    , kItems :: [Item]
    }

instance Show Knapsack where
  show :: Knapsack -> String
  show (Knapsack size elems) =
    "Knapsack size: " ++ show size ++ "\nElements: " ++ show elems

_items :: [Item]
_items =
  [ Item "Guitar" (Size 1) (Value 1500)
  , Item "Phone" (Size 2) (Value 2500)
  , Item "Brown fox" (Size 1) (Value 1000)
  , Item "Brown fox" (Size 1) (Value 500)
  ]

-- | Brutto solution in order to reuse in the dynamic one
mostValueable :: Size -> [Item] -> [Item]
mostValueable size items =
  maximumBy
    (compare `on` sum . map iValue)
    [ x
    | x <- subsequences items
    , foldl (\acc item -> acc + iSize item) 0 x <= size
    ]

-- | Brutto solution
mostValueableB :: Size -> [Item] -> Knapsack
mostValueableB size = Knapsack size . mostValueable size

-- | Dynamic solution
-- mostValueableD items size = moveRight items size
--   where
--     moveRight (x:xs) s =
--       case s of
--         Size 1 -> moveDown [] 1
--         _      -> moveRight (moveDown x xs s) (s - 1)

--     moveDown _ [z] s    = mostValueable s [z]
--     moveDown x (z:zs) s = moveDown (mostValueable s (x ++ [z])) zs s
--
-- $> mostValueableB 4 _items
