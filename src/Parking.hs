{-# LANGUAGE InstanceSigs   #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE StrictData     #-}

module Parking where

data Vehicle
  = Motorcycle
  | Car
  | Van
  deriving (Show, Eq)

data SpotType
  = Small
  | Compact
  | Large
  deriving (Show, Eq, Ord)

data Size
  = One
  | Three
  | Six
  deriving (Show, Eq, Ord)

spotType :: Size -> SpotType
spotType One   = Small
spotType Three = Compact
spotType Six   = Large

vehicleSize :: Maybe Vehicle -> Size
vehicleSize (Just Motorcycle) = One
vehicleSize (Just Car)        = Three
vehicleSize (Just Van)        = Six
vehicleSize Nothing           = Three -- default vehicle size

avaliability :: Maybe Vehicle -> Bool
avaliability Nothing = True
avaliability _       = False

data Spot =
  Spot
    { vehicle     :: !(Maybe Vehicle)
    , size        :: !Size
    , typo        :: !SpotType
    , isAvailable :: !Bool
    }

mkSpot :: Maybe Vehicle -> Spot
mkSpot vehicle =
  Spot
    { vehicle
    , size = vehicleSize vehicle
    , typo = (spotType . vehicleSize) vehicle
    , isAvailable = avaliability vehicle
    }

instance Show Spot where
  show :: Spot -> String
  show (Spot v s t a) =
    "\n Spot (Type: " ++
    show t ++
    ", Vehicle: " ++
    show v ++ ", Size: " ++ show s ++ ", Avaliable: " ++ show a ++ ")"

newtype ParkingLot =
  ParkingLot
    { spots :: [Spot]
    }

instance Show ParkingLot where
  show :: ParkingLot -> String
  show (ParkingLot a) = "Parking: " ++ show a

testData :: ParkingLot
testData =
  ParkingLot
    [ mkSpot $ Just Van
    , mkSpot $ Just Motorcycle
    , mkSpot $ Just Car
    , mkSpot $ Just Van
    , mkSpot Nothing
    ]
--
-- $> testData
