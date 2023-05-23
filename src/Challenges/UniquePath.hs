{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}

module Challenges.UniquePath where

-- Pre-requirements: introduce IO Vector type
import           Control.Monad.Reader (MonadIO (liftIO), MonadReader (ask),
                                       ReaderT (runReaderT))
import qualified Data.Vector.Mutable  as MV
import           Prelude              (Applicative, Functor, IO, Int,
                                       Monad (return, (>>)), Num ((+), (-)),
                                       ($))

type Grid = MV.IOVector Int

newtype VectorIO a =
  VectorIO (ReaderT Grid IO a)
  deriving (Functor, Applicative, Monad, MonadReader Grid, MonadIO)

-- Run your computation over an existing vector
runComputation :: Grid -> VectorIO a -> IO Grid
runComputation vector (VectorIO action) =
  runReaderT action vector >> return vector

-- Run your computation over a new vector of the specified length
runNewComputation :: Int -> VectorIO a -> IO Grid
runNewComputation n action = do
  vector <- MV.new n
  runComputation vector action

putInVec :: Int -> Int -> VectorIO ()
putInVec idx val = do
  v <- ask
  liftIO $ MV.write v idx val

getFromVec :: Int -> VectorIO Int
getFromVec idx = do
  v <- ask
  liftIO $ MV.read v idx

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
-- Naive implementation with O(2^(n + m)):
--
pathsNaive :: Int -> Int -> Int
pathsNaive n m =
  case (n, m) of
    (_, 0) -> 0
    (0, _) -> 0
    (1, 1) -> 1
    (n, m) -> pathsNaive (n - 1) m + pathsNaive n (m - 1)

-- -- $> pathsNaive 5 4
pathsMemoized :: Int -> Int -> Int
pathsMemoized n m =
  case (n, m) of
    (_, 0) -> 0
    (0, _) -> 0
    (1, 1) -> 1
    (n, m) -> pathsNaive (n - 1) m + pathsNaive n (m - 1)
