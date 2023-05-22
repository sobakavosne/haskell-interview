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

import           Control.Monad (replicateM)
import           Data.IORef    (IORef, newIORef, readIORef)
import           GHC.Conc      (STM, TVar, atomically, newTVar, readTVar,
                                writeTVar)
import           GHC.IORef     (writeIORef)

incrementer :: Num a => IORef a -> IO [()]
incrementer ref = do
  replicateM
    10
    do x <- readIORef ref
    -- Here is the switching of the process can appear
    -- and the data race is occured
       writeIORef ref (x + 1)

main :: IO ()
main = do
  counter <- newIORef 0
  -- async (incrementer counter)
  -- async (incrementer counter)
  -- threadDelay 1000
  print =<< readIORef counter -- waiting for 20, but it can be not: data race

-- To avoid data race use STM (Software Transactional Memory)
incrementerT :: TVar Int -> IO [()]
incrementerT ref = do
  replicateM
    10
    do atomically
         do x <- readTVar ref
            writeTVar ref (x + 1)

mainT :: STM Integer
mainT = do
  counter <- newTVar 0
  -- async (incrementer counter)
  -- async (incrementer counter)
  -- threadDelay 1000
  readTVar counter -- будет точно 20
