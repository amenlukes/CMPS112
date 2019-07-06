{--
-- Shawn Chumbar (schumbar@ucsc.edu)
-- CMPS130: HW3
-- Professor Owen Arden
-- May 5th, 2019
-- Extra Comments/Concerns: I recieved most of any help that I got from either MSI, or from my partner, Arturo Lopez.
-- A lot of help was recieved from Kitlao from Piazza.
--  
--  For bigAdd, bigMul, and mulByDigit, I discussed the functions with Joshua Rony from MSI. 
--  He helped me on bigMul by helping me understand the purpose of the first element in the 
--  resultant pair and how it was supposed to denote the number of 0's to append when shifting the multiplier digit to 
--  the right.
--}


{- | CSE 130: All about fold.

     For this assignment, you may use the following library functions:

     length
     append (++)
     map
     foldl'
     foldr
     unzip
     zip
     reverse

  Use www.haskell.org/hoogle to learn more about the above.

  Do not change the skeleton code! The point of this assignment
  is to figure out how the functions can be written this way
  (using fold). You may only replace the `error "TBD:..."` terms.
  
  import debug.trace which functions as an identity function and prints out string

-}

module Hw3 where

import Prelude hiding (replicate, sum)
import Data.List (foldl')
import Debug.Trace

foldLeft :: (a -> b -> a) -> a -> [b] -> a
foldLeft = foldl'

--------------------------------------------------------------------------------
-- | sqSum [x1, ... , xn] should return (x1^2 + ... + xn^2)
--
-- >>> sqSum []
-- 0
--
-- >>> sqSum [1,2,3,4]
-- 30
--
-- >>> sqSum [(-1), (-2), (-3), (-4)]
-- 30

sqSum :: [Int] -> Int
sqSum xs = foldLeft f base xs
  where
   f a x = a + x^2
   base  = 0

--------------------------------------------------------------------------------
-- | `pipe [f1,...,fn] x` should return `f1(f2(...(fn x)))`
--
-- >>> pipe [] 3
-- 3
--
-- >>> pipe [(\x -> x+x), (\x -> x + 3)] 3
-- 12
--
-- >>> pipe [(\x -> x * 4), (\x -> x + x)] 3
-- 24

--test2 = [(\x->x+x), (\x->x+3)] 3
--test1 = [] 3
--test3 = [(\x->x*4), (\x -> x + x)] 3

pipe :: [(a -> a)] -> (a -> a)
pipe fs   = foldLeft f base fs
  where
    f a x  = (a.x)
    base   = id --identity function

--------------------------------------------------------------------------------
-- | `sepConcat sep [s1,...,sn]` returns `s1 ++ sep ++ s2 ++ ... ++ sep ++ sn`
--
-- >>> sepConcat "---" []
-- ""
--
-- >>> sepConcat ", " ["foo", "bar", "baz"]
-- "foo, bar, baz"
--
-- >>> sepConcat "#" ["a","b","c","d","e"]
-- "a#b#c#d#e"

sepConcat :: String -> [String] -> String
sepConcat sep []     = ""
sepConcat sep (x:xs) = foldLeft f base l
  where
    f a x            = a ++ sep ++ x
    base             = x
    l                = xs

intString :: Int -> String
intString = show

--------------------------------------------------------------------------------
-- | `stringOfList pp [x1,...,xn]` uses the element-wise printer `pp` to
--   convert the element-list into a string:
--
-- >>> stringOfList intString [1, 2, 3, 4, 5, 6]
-- "[1, 2, 3, 4, 5, 6]"
--
-- >>> stringOfList (\x -> x) ["foo"]
-- "[foo]"
--
-- >>> stringOfList (stringOfList show) [[1, 2, 3], [4, 5], [6], []]
-- "[[1, 2, 3], [4, 5], [6], []]"

stringOfList :: (a -> String) -> [a] -> String
--stringOfList f xs = error "TBD:stringOfList"
stringOfList f xs =  "[" ++ (sepConcat ", " (map f xs)) ++ "]"

--------------------------------------------------------------------------------
-- | `clone x n` returns a `[x,x,...,x]` containing `n` copies of `x`
--
-- >>> clone 3 5
-- [3,3,3,3,3]
--
-- >>> clone "foo" 2
-- ["foo", "foo"]

clone :: a -> Int -> [a]
clone x n = if (n >= 1)
              then [x] ++ (clone (x) (n-1)) 
              else []

type BigInt = [Int]

--------------------------------------------------------------------------------
-- | `padZero l1 l2` returns a pair (l1', l2') which are just the input lists,
--   padded with extra `0` on the left such that the lengths of `l1'` and `l2'`
--   are equal.
--
-- >>> padZero [9,9] [1,0,0,2]
-- [0,0,9,9] [1,0,0,2]
--
-- >>> padZero [1,0,0,2] [9,9]
-- [1,0,0,2] [0,0,9,9]

padZero :: BigInt -> BigInt -> (BigInt, BigInt)
padZero l1 l2 
    | (length l1 < length l2)  = (((clone 0 (length l2 - length l1)) ++ l1), l2)
    | (length l1 > length l2)  = (l1, ((clone 0 (length l1 - length l2)) ++ l2))
    | (length l1 == length l2) = (l1, l2)

--------------------------------------------------------------------------------
-- | `removeZero ds` strips out all leading `0` from the left-side of `ds`.
--
-- >>> removeZero [0,0,0,1,0,0,2]
-- [1,0,0,2]
--
-- >>> removeZero [9,9]
-- [9,9]
--
-- >>> removeZero [0,0,0,0]
-- []

removeZero :: BigInt -> BigInt
removeZero []     = []
removeZero (d:ds) = if (d == 0)
                  then removeZero ds
                  else [d] ++ ds

--------------------------------------------------------------------------------
-- | `bigAdd n1 n2` returns the `BigInt` representing the sum of `n1` and `n2`.
-- >>> bigAdd [9, 9] [1, 0, 0, 2]
-- [1, 1, 0, 1]
-- >>> bigAdd [9, 9, 9, 9] [9, 9, 9]
-- [1, 0, 9, 9, 8]
bigAdd :: BigInt -> BigInt -> BigInt
bigAdd l1 l2     = removeZero res
  where
    (l1', l2')   = padZero l1 l2
    res          = foldLeft f base args
    f a x 
      | ((fst x + snd x)  >= 10)  = (bigAdd (a) [(fst x + snd x) `div` 10]) ++ [(fst x + snd x) `mod` 10]
      | ((fst x + snd x)  <  10)  = a ++ [(fst x + snd x)]
    base         = []
    args         = (zip l1' l2')
      

--------------------------------------------------------------------------------
-- | `mulByDigit i n` returns the result of multiplying
--   the digit `i` (between 0..9) with `BigInt` `n`.
-- | `bigAdd n1 n2` returns the `BigInt` representing the sum of `n1` and `n2`.
--
-- >>> mulByDigit 9 [9,9,9,9]
-- [8,9,9,9,1]

mulByDigit :: Int -> BigInt -> BigInt
mulByDigit i n 
-- i>1 = bigAdd n (multByDigit (i-1) n)
          | (i == 0) = [0]
          | (i == 1) = n
          | (i > 1)  = (pipe (clone (bigAdd n) (i-1)) n)

--------------------------------------------------------------------------------
-- | `bigMul n1 n2` returns the `BigInt` representing the product of `n1` and `n2`.
--
-- >>> bigMul [9,9,9,9] [9,9,9,9]
-- [9,9,9,8,0,0,0,1]
--
-- >>> bigMul [9,9,9,9,9] [9,9,9,9,9]
-- [9,9,9,9,8,0,0,0,0,1]


bigMul :: BigInt -> BigInt -> BigInt
bigMul l1 l2 = res
  where
    (_, res) = foldLeft f base args
    f a x    = (  (fst a + 1), ( bigAdd (snd a) ((mulByDigit x l1) ++ (clone 0 (fst a))) )  )
    base     = (0,[0])
    args     = l2