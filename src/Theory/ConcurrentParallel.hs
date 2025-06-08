-- async
--
-- concurrency, parallels
--
-- green thread
-- program1 = do
--   print "a"
--   print "b"
--   print "c"
-- program2 = do
--   print "e"
--   print "f"
--   print "g"
-- parallel
-- "a""be"""
-- ...
-- concurrency
-- async program1
-- async program2
-- "a"
-- "e"
-- "b"
-- "f"
-- ..
-- run main greenthread
--
-- async :: IO () -> IO AsyncId
{-# LANGUAGE BlockArguments #-}

module Theory.ConcurrentParallel where

import           Control.Concurrent.Async (async, wait)
import           Control.Monad            (replicateM)
import           Data.IORef               (IORef, newIORef, readIORef)
import           GHC.Conc                 (TVar, atomically, newTVarIO,
                                           readTVar, readTVarIO, threadDelay,
                                           writeTVar)
import           GHC.IORef                (writeIORef)

incrementor :: Num a => IORef a -> IO [()]
incrementor ref = do
  replicateM
    10
    do
      x <- readIORef ref
    -- Here is the switching of the process can appear
    -- and the data race is occurred
      writeIORef ref (x + 1)

main :: IO ()
main = do
  counter <- newIORef (0 :: Integer)
  _ <- async (incrementor counter)
  _ <- async (incrementor counter)
  threadDelay 10
  print =<< readIORef counter -- waiting for 20, but it can be not: data race

-- To avoid data race use STM (Software Transactional Memory)
incrementorT :: TVar Int -> IO [()]
incrementorT ref = do
  replicateM
    10
    do
      atomically
        do
          x <- readTVar ref
          writeTVar ref (x + 1)

mainT :: IO ()
mainT = do
  counter <- newTVarIO 0 -- newTVarIO ≡ atomically . newTVar
  a1 <- async (incrementorT counter)
  a2 <- async (incrementorT counter)
  _ <- wait a1
  _ <- wait a2
  final <- readTVarIO counter -- readTVarIO ≡ atomically . readTVar
  print final -- guaranteed to be 20
--
-- $> main
--
-- $> mainT
