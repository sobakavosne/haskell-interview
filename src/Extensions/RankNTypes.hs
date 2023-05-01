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
--
-- $> rank (flip elem) 1
