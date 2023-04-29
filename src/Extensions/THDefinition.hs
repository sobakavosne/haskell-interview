module Extensions.THDefinition where

import           Language.Haskell.TH (DecsQ, ExpQ, clause, funD, mkName,
                                      normalB)

genFunc :: String -> ExpQ -> DecsQ
genFunc name body = do
  let funcName = mkName name
  funcDecl <- funD funcName [clause [] (normalB body) []]
  return [funcDecl]
