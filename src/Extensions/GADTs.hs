{-# LANGUAGE GADTs #-}

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
