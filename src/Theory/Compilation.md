```
module X where
  f True = not True
  f False = not False

1. Parse to AST : String -> AST

< Abstract Syntax Tree of module X >

2. Name resolution : AST -> AST

module X where
  X.f Data.Bool.True = Prelude.not Data.Bool.True
  X.f Data.Bool.False = Prelude.not Data.Bool.False

3. Typecheking and type infering : AST -> AST

module X where
  X.f :: Data.Bool.Bool -> Data.Bool.Bool
  X.f Data.Bool.True = Prelude.not Data.Bool.True
  X.f Data.Bool.False = Prelude.not Data.Bool.False

4. Desugaring to Core: AST -> Core

module X where
  X.f :: Data.Bool.Bool -> Data.Bool.Bool
  X.f x = case x of
    Data.Bool.True -> Prelude.not Data.Bool.True
    Data.Bool.False -> Prelude.not Data.Bool.False

5. Apply optimizations: Core -> Core, for example inlining

module X where
  X.f :: Data.Bool.Bool -> Data.Bool.Bool
  X.f x = case x of
    Data.Bool.True -> (\x -> case x of True -> False; False -> True) Data.Bool.True
    Data.Bool.False -> (\x -> case x of True -> False; False -> True) Data.Bool.False

module X where
  X.f :: Data.Bool.Bool -> Data.Bool.Bool
  X.f x = case x of
    Data.Bool.True -> case Data.Bool.True of True -> False; False -> True)
    Data.Bool.False -> case Data.Bool.False of True -> False; False -> True

module X where
  X.f :: Data.Bool.Bool -> Data.Bool.Bool
  X.f x = case x of
    Data.Bool.True -> Data.Bool.False
    Data.Bool.False -> Data.Bool.True

6. Compile Core -> STG (Spineless Tagless G-machine)

7. Compile : STG -> C--

8. Compile to ASM : C-- -> ASM
```

```
Before compilation:

data X = A | B | C

x = C

main =
  case x of
    A -> print "a"
    B -> print "b"
    C -> print "c"

After compilation:

x:
  qword 0 -- 0 is not forced, 1 -- is forced
  qword THUNK_TAG
  qword <pointer_to_thunk>

<pointer_to_thunk>:
  x[0] = 1
  x[1] = BOXED_TAG
  x[2] = 2 -- tag for C
  return

main:
  ....
  if x[0] == 0 then
    call x[2]
  // now x == [1, BOXED_TAG, 2]
  if x[2] == 0 then
    print "a"
  if x[2] == 1 then
    print "b"
  if x[2] == 2 then
    print "c"
  ...
```
