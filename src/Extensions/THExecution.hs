{-# LANGUAGE TemplateHaskell #-}

module Extensions.THExecution
  ( executeTHDefinition
  ) where

import           Extensions.THDefinition (genFunc)

--
-- set an option to show compile time injections
-- :set -ddump-splices
--
-- Splicing Declaration is a mechanism that allows to inject
-- Haskell code into another module at compile time
--
$(genFunc "square" [|\x -> x * x|])

executeTHDefinition :: IO ()
executeTHDefinition = do
  let x = 5
  putStrLn $ "Square of " ++ show x ++ " is " ++ show (square x)
