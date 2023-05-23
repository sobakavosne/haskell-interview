# YouTube Link (Comparing): https://www.youtube.com/watch?v=zrOIQEN3Wkk
# Problem Link (Contest):  https://leetcode.com/contest/weekly-contest-210/problems/maximum-nesting-depth-of-the-parentheses/
# Problem Link (Practice): https://leetcode.com/problems/maximum-nesting-depth-of-the-parentheses/

import functools as F
import builtins as B


# the evaluation of function composition is started from the last function
def compose(*fns):
  return F.reduce(
    lambda f, g: lambda x: f(g(x)), 
    fns, 
    lambda x: x
  )


def scan(lst, acc = 0):
  return [acc := acc + x for x in lst]


def mapBraces(lst):
  return map(lambda x: 1 if x == '(' else 0, lst)


def filterBraces(lst):
  return filter(lambda x: x in ['(', ')'], lst)


def maxDepth(string):
  return compose(
    B.max,
    scan,
    mapBraces,
    filterBraces,
    list
  )(string)


print("maxDepth: ", maxDepth("(1 + (3 / (10 - 5)))"))