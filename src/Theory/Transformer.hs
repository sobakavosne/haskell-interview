module Theory.Transformer where

import           Control.Monad.State (MonadIO (liftIO), MonadState (get, put),
                                      StateT (runStateT))

type Counter = StateT Int IO

incrementCounter :: Counter ()
incrementCounter = do
  counter <- get
  put (counter + 1)
  liftIO $ putStrLn ("Counter is now " ++ show (counter + 1))

main :: IO ((), Int)
main = do
  runStateT incrementCounter 0
  runStateT incrementCounter 1
--
-- $> main
