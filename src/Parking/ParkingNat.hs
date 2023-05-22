{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE InstanceSigs         #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE UndecidableInstances #-}

module Parking.ParkingNat where

import           GHC.TypeLits (type (+), type (-))
import           GHC.TypeNats (Nat, type (+))

data Vehicle
  = Motorcycle
  | Car
  | Van
  deriving (Show, Eq)

data SpotType
  = Small
  | Compact
  | Large
  deriving (Show, Eq)

type Three = 3

type Two = 2

type Five = Two + Three

type family ListOfN (n :: Nat) where
  ListOfN 0 = '[]
  ListOfN n = Int : ListOfN (n - 1)

data Spot a =
  Spot
    { spotType :: SpotType
    , vehicle  :: Vehicle
    }

-- CompactSpot :: {spotType :: SpotType, vehicle :: Vehicle} -> Spot a
-- LargeSpot :: {spotType :: SpotType, vehicle :: Vehicle} -> Spot a
instance Show (Spot a) where
  show :: Spot a -> String
  show (Spot t v) = "Type: " ++ show t ++ "Vehicle: " ++ show v

newtype ParkingLot a =
  ParkingLot
    { spots :: [Spot a]
    }

instance Show (ParkingLot a) where
  show :: ParkingLot a -> String
  show (ParkingLot a) = "Parking: " ++ show a

testData :: ParkingLot a
testData =
  ParkingLot
    [ Spot Small Motorcycle
    , Spot Compact Car
    , Spot Large Van
    , Spot Small Motorcycle
    ]
--
-- $> testData
