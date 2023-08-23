module EncryptionProtocol.DiffieHellman where

import           Control.Exception (assert)

type Secret = Integer

type PublicBase = Integer

type PublicModulus = Integer

type PublicKey = Integer

type SecretKey = Integer

createPubKey :: PublicBase -> Secret -> PublicModulus -> PublicKey
createPubKey g a p = g ^ a `mod` p

createSecretKey :: PublicKey -> Secret -> PublicModulus -> SecretKey
createSecretKey k a p = k ^ a `mod` p

-- 1. Alice and Bob publicly agree to use a modulus p = 23
-- and base g = 5 (which is a primitive root modulo 23)
--
publicBase :: PublicBase
publicBase = 5

publicModulus :: PublicModulus
publicModulus = 23

-- 2. Alice chooses a secret integer a = 4, then sends Bob A = g ^ a mod p
--
alicePubKey :: Integer
alicePubKey = createPubKey publicBase 4 publicModulus

-- 3. Bob chooses a secret integer b = 3, then sends Alice B = g ^ b mod p
--
bobPubKey :: Integer
bobPubKey = createPubKey publicBase 3 publicModulus

-- 4. Alice computes s = B ^ a mod p
--
aliceSecretKey :: SecretKey
aliceSecretKey = createSecretKey bobPubKey 4 publicModulus

-- 5. Bob computes s = A ^ b mod p
--
bobSecretKey :: SecretKey
bobSecretKey = createSecretKey alicePubKey 3 publicModulus
--
-- $> assert (bobSecretKey == aliceSecretKey) "Succes"
