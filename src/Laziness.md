```c
x = (1, 2)
```
```c
x = malloc(THUNK_SIZE)
x.evaluated = true
x.value = lbl
```

```c
lbl:
  y = malloc(HEAP_SIZE_FOR(2))
  y.tag = TUPLE
  y.values[0] = maloc(THUNK_SIZE)
  ...
```
```c
before evaluated:
[0, pointer_to_thunk] ... pointer_to_thunk: [the code than makes the tuple]
```

```c
after tuple evaluated:
[1, pointer_to_tuple] ... pointer_to_tuple: [tag: TUPLE, value0: pointer_to_thunk1, value2: pointer_to_thunk2]
... pointer_to_thunk1: [the code than makes the tuple 1]
... pointer_to_thunk2: [the code than makes the tuple 2]
```
