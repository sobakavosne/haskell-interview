{-# LANGUAGE GADTs      #-}
{-# LANGUAGE RankNTypes #-}

module Extensions.RankNTypes where

rank ::
     (forall a. Eq a =>
                  [a] -> a -> Bool)
  -> Int
  -> Int
rank p x =
  if p [x] x
    then x
    else 0

-- data Term a
--   = Lit Int
--   | Succ (Term Int)
--   | IsZero (Term Int)
--   | If (Term Bool) (Term a) (Term a)
--   | Pair (Term a) (Term b)           -- type b not in scope
--
data Term a where
  Lit :: Int -> Term Int
  Succ :: Term Int -> Term Int
  IsZero :: Term Int -> Term Bool
  If :: Term Bool -> Term a -> Term a -> Term a
  Pair :: Term a -> Term b -> Term (a, b)
--
-- $> rank (flip elem) 1
