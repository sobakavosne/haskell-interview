```
x = [1,2,3]
y = 0:x
y = Cons 0 <pointer thunk for to x>

newtype Text = Text (Array Char)
string, text, bytestring, lazy.bytestring

data List a
  = Nil
  | Cons a (List a)

For a string of 1000 symbols there are 2001 objects in a heap:
  1000 (Char) + 1000 (Cons) + 1 (Nil) = 2001

Text.size "he¬lo" == 5
ByteString.size "he¬lo" == 6
```