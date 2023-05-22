module Theory.LiftedUnlifted where

-- String :: Type
--
x :: String
x = "hello"

-- type Email = String
--
f :: Email -> IO ()
f email = do
  sendToEmail email "msg"

sendToEmail :: Email -> String -> IO ()
sendToEmail = undefined

-- occasionally apply string to functin, that awaits email
-- f x -- typechecks, but nonsense
--
newtype Email =
  MkEmail String

-- g :: Email -> IO ()
-- g (MkEmail email) = do
--   sendToEmail email "msg"
--
-- g x -- will not typechecks
email :: Email
email = MkEmail "a@b.com"

-- g email
--
-- after compilation in Core
-- email = "a@b.com"
-- f email
--
-- lifted: Int
-- unlifted: Int#
--
-- (1 + 2) `seq` 0
-- |
-- v
-- 3
--
-- (1 + 2, 3) `seq` 0
-- |
-- v
-- (1 + 2, 3)
--
data X
  = A Int
  | B Int Int

y :: X
y = B 0 1
-- y == <thunk>
--
-- y `seq` 0
-- y == B <thunk> <thunk>
--
-- 42   -> pointer_to_thunk_for_int
-- A 42 -> { tag: BOXED, value_tag: 0 (0 is A), value0: pointer_to_thunk_for_int }
--
-- data A = A Int
-- ghci> A undefined `seq` 0
-- 0 -- ok
--
-- newtype A = A Int
-- ghci> A undefined `seq` 0
-- *** Exception: Prelude.undefined
--
-- `type` is a 