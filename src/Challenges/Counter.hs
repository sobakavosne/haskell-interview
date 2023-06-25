module Challenges.Counter where

import           Data.IORef (IORef, newIORef, readIORef, writeIORef)

incrementCounter :: IORef Int -> IO ()
incrementCounter counter = do
  currentValue <- readIORef counter
  let newValue = currentValue + 1
  writeIORef counter newValue

printCounter :: IORef Int -> IO ()
printCounter counter = do
  currentValue <- readIORef counter
  putStrLn $ "Counter: " ++ show currentValue

main :: IO ()
main = do
  counter <- newIORef 0
  incrementCounter counter
  incrementCounter counter
  incrementCounter counter
  printCounter counter
