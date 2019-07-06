{-# LANGUAGE OverloadedStrings #-}

module Language.Nano.Eval
  ( execFile, execString, execExpr
  , eval, lookupId, prelude
  , parse
  , env0
  )
  where

import Control.Exception (throw, catch)
import Language.Nano.Types
import Language.Nano.Parser

--------------------------------------------------------------------------------
execFile :: FilePath -> IO Value
--------------------------------------------------------------------------------
execFile f = (readFile f >>= execString) `catch` exitError

--------------------------------------------------------------------------------
execString :: String -> IO Value
--------------------------------------------------------------------------------
execString s = execExpr (parseExpr s) `catch` exitError

--------------------------------------------------------------------------------
execExpr :: Expr -> IO Value
--------------------------------------------------------------------------------
execExpr e = return (eval prelude e) `catch` exitError

--------------------------------------------------------------------------------
-- | `parse s` returns the Expr representation of the String s
--
-- >>> parse "True"
-- EBool True
--
-- >>> parse "False"
-- EBool False
--
-- >>> parse "123"
-- EInt 123
--
-- >>> parse "foo"
-- EVar "foo"
--
-- >>> parse "x + y"
-- EBin Plus (EVar "x") (EVar "y")
--
-- >>> parse "if x <= 4 then a || b else a && b"
-- EIf (EBin Le (EVar "x") (EInt 4)) (EBin Or (EVar "a") (EVar "b")) (EBin And (EVar "a") (EVar "b"))
--
-- >>> parse "if 4 <= z then 1 - z else 4 * z"
-- EIf (EBin Le (EInt 4) (EVar "z")) (EBin Minus (EInt 1) (EVar "z")) (EBin Mul (EInt 4) (EVar "z"))
--
-- >>> parse "let a = 6 * 2 in a /= 11"
-- ELet "a" (EBin Mul (EInt 6) (EInt 2)) (EBin Ne (EVar "a") (EInt 11))
--
-- >>> parseTokens "() (  )"
-- Right [LPAREN (AlexPn 0 1 1),RPAREN (AlexPn 1 1 2),LPAREN (AlexPn 3 1 4),RPAREN (AlexPn 6 1 7)]
--
-- >>> parse "f x"
-- EApp (EVar "f") (EVar "x")
--
-- >>> parse "(\\ x -> x + x) (3 * 3)"
-- EApp (ELam "x" (EBin Plus (EVar "x") (EVar "x"))) (EBin Mul (EInt 3) (EInt 3))
--
-- >>> parse "(((add3 (x)) y) z)"
-- EApp (EApp (EApp (EVar "add3") (EVar "x")) (EVar "y")) (EVar "z")
--
-- >>> parse <$> readFile "tests/input/t1.hs"
-- EBin Mul (EBin Plus (EInt 2) (EInt 3)) (EBin Plus (EInt 4) (EInt 5))
--
-- >>> parse <$> readFile "tests/input/t2.hs"
-- ELet "z" (EInt 3) (ELet "y" (EInt 2) (ELet "x" (EInt 1) (ELet "z1" (EInt 0) (EBin Minus (EBin Plus (EVar "x") (EVar "y")) (EBin Plus (EVar "z") (EVar "z1"))))))
--
-- >>> parse "1-2-3"
-- EBin Minus (EBin Minus (EInt 1) (EInt 2)) (EInt 3)
-- >>> parse "1+a&&b||c+d*e-f-g x"
-- EBin Or (EBin And (EBin Plus (EInt 1) (EVar "a")) (EVar "b")) (EBin Minus (EBin Minus (EBin Plus (EVar "c") (EBin Mul (EVar "d") (EVar "e"))) (EVar "f")) (EApp (EVar "g") (EVar "x")))
--
-- >>> parse "1:3:5:[]"
-- EBin Cons (EInt 1) (EBin Cons (EInt 3) (EBin Cons (EInt 5) ENil))
--
-- >>> parse "[1,3,5]"
-- EBin Cons (EInt 1) (EBin Cons (EInt 3) (EBin Cons (EInt 5) ENil))

--------------------------------------------------------------------------------
parse :: String -> Expr
--------------------------------------------------------------------------------
parse = parseExpr

exitError :: Error -> IO Value
exitError (Error msg) = return (VErr msg)

--------------------------------------------------------------------------------
-- | `eval env e` evaluates the Nano expression `e` in the environment `env`
--   (i.e. uses `env` for the values of the **free variables** in `e`),
--   and throws an `Error "unbound variable"` if the expression contains
--   a free variable that is **not bound** in `env`.
--
-- part (a)
--
-- >>> eval env0 (EBin Minus (EBin Plus "x" "y") (EBin Plus "z" "z1"))
-- 0
--
-- >>> eval env0 "p"
-- *** Exception: Error {errMsg = "unbound variable: p"}
--
-- part (b)
--
-- >>> eval []  (EBin Le (EInt 2) (EInt 3))
-- True
--
-- >>> eval []  (EBin Eq (EInt 2) (EInt 3))
-- False
--
-- >>> eval []  (EBin Eq (EInt 2) (EBool True))
-- *** Exception: Error {errMsg = "type error: binop"}
--
-- >>> eval []  (EBin Lt (EInt 2) (EBool True))
-- *** Exception: Error {errMsg = "type error: binop"}
--
-- >>> let e1 = EIf (EBin Lt "z1" "x") (EBin Ne "y" "z") (EBool False)
-- >>> eval env0 e1
-- True
--
-- >>> let e2 = EIf (EBin Eq "z1" "x") (EBin Le "y" "z") (EBin Le "z" "y")
-- >>> eval env0 e2
-- False
--
-- part (c)
--
-- >>> let e1 = EBin Plus "x" "y"
-- >>> let e2 = ELet "x" (EInt 1) (ELet "y" (EInt 2) e1)
-- >>> eval [] e2
-- 3
--
-- part (d)
--
-- >>> eval [] (EApp (ELam "x" (EBin Plus "x" "x")) (EInt 3))
-- 6
--
-- >>> let e3 = ELet "h" (ELam "y" (EBin Plus "x" "y")) (EApp "f" "h")
-- >>> let e2 = ELet "x" (EInt 100) e3
-- >>> let e1 = ELet "f" (ELam "g" (ELet "x" (EInt 0) (EApp "g" (EInt 2)))) e2
-- >>> eval [] e1
-- 102
--
-- part (e)
-- |
-- >>> :{
-- eval [] (ELet "fac" (ELam "n" (EIf (EBin Eq "n" (EInt 0))
--                                  (EInt 1)
--                                  (EBin Mul "n" (EApp "fac" (EBin Minus "n" (EInt 1))))))
--             (EApp "fac" (EInt 10)))
-- :}
-- 3628800
--
-- part (f)
--
-- >>> let el = EBin Cons (EInt 1) (EBin Cons (EInt 2) ENil)
-- >>> execExpr el
-- (1 : (2 : []))
-- >>> execExpr (EApp "head" el)
-- 1
-- >>> execExpr (EApp "tail" el)
-- (2 : [])
--------------------------------------------------------------------------------
eval :: Env -> Expr -> Value
--------------------------------------------------------------------------------
{-- 
EInt, EBool, ENil: 
  Pattern matching allows us to take the Expr value and put it into the Value data type. 
  i.e. EInt 3 becomes VInt 3. 
--}
eval _ (EInt i)  = (VInt i)
eval _ (EBool b) = (VBool b)
eval _ (ENil)    = (VNil)
{-- 
EVar: If there is some variable in the environment, we have to perform a 
  lookup on that variable to get the value that the variable represents.
--}
eval env (EVar id) = (lookupId id env)
{--
EBin: When trying to evaluate a Binary operation, we can just call evalOp on
  the evaluation of expr1 and expr2. 
--}
eval env (EBin func expr1 expr2) = evalOp func (eval env expr1) (eval env expr2)
{-- 
EIf: We have to check if the boolean boolean statement is neither true or false. If its neither, then it is 
  not a boolean statement and an error should be thrown. Else if it is a boolean statement, check whether it
  is true or false and do the appropriate expression. 
--}
eval env (EIf p t f)
          | (eval env p) /= (VBool True) && (eval env p) /= (VBool False) = throw (Error ("type error: EIf")) --VErr("type error: EIf")
          | (eval env p) == (VBool True)  = (eval env t)
          | (eval env p) == (VBool False) = (eval env f)
          | otherwise = throw (Error ("type error: EIf")) --VErr("type error: EIf") 
{-- 
ELet: We need to make it so that the id and the evaluation of expression 1 get added to the environment,
  And we call that new environment when evaluating e2.
--}
eval env (ELet id e1 e2) = eval bodyEnv e2
                            where
                              val = eval bodyEnv e1
                              bodyEnv = ([(id, (val))] ++ env)                              
{--
ELam: This is nothing more than saving the environment when doing \id -> e.
--}
eval env (ELam id e) = (VClos env id e)
{--
EApp: We will have different cases depending on whether expr1 is a function or not.
  When we evaluate expr1, we check if it is a function (by doing the VClos... stuff on it). If it is a function,
  We want to evaluate the 2nd expression and apply it to the function e1.
  From README: EApp e1 e2 corresponds to the Haskell expression e1 e2
  (i.e. applying the argument e2 to the function e1).
--}
eval env (EApp expr1 expr2) = case (eval env expr1) of 
                                (VClos bodyEnv id expr)  -> eval ([(id, eval env expr2)] ++ bodyEnv) expr
                                VPrim func -> func (eval env expr2) 
                                _ -> throw (Error ("type error: EApp")) --VErr("type error: EApp")

--------------------------------------------------------------------------------
evalOp :: Binop -> Value -> Value -> Value
--------------------------------------------------------------------------------
{--
In each of these cases, we are first going to be checking that the various binary 
  operators are each taking in the correct data type that they need and performing the
  binary operation on those arguments. However, if the data types do not match up,
  then we will be throwing errors stating that we have a type error.
--}
evalOp Plus  (VInt x1)       (VInt x2)       = VInt (x1+x2)
-- evalOp Plus  (VInt x1)       _               = throw (Error ("type error: Plus"))  --VErr("type error: Plus") 
-- evalOp Plus  _               (VInt x2)       = throw (Error ("type error: Plus"))  --VErr("type error: Plus") 
evalOp Plus  _               _               = throw (Error ("type error: Plus"))  --VErr("type error: Plus") 

evalOp Minus (VInt x1)       (VInt x2)       = VInt (x1-x2)
-- evalOp Minus (VInt x1)       _               = throw (Error ("type error: Minus")) --VErr("type error: Minus") 
-- evalOp Minus _               (VInt x2)       = throw (Error ("type error: Minus")) --VErr("type error: Minus") 
evalOp Minus _               _               = throw (Error ("type error: Minus")) --VErr("type error: Minus") 

evalOp Mul   (VInt x1)       (VInt x2)       = VInt (x1*x2)
-- evalOp Mul   (VInt x1)       _               = throw (Error ("type error: Mul"))   --VErr("type error: Mul") 
-- evalOp Mul   _               (VInt x2)       = throw (Error ("type error: Mul"))   --VErr("type error: Mul") 
evalOp Mul   _               _               = throw (Error ("type error: Mul"))   --VErr("type error: Mul") 

evalOp Div   (VInt x1)       (VInt x2)       = VInt (x1 `div` x2)
-- evalOp Div   (VInt x1)       _               = throw (Error ("type error: Div"))   --VErr("type error: Div")
-- evalOp Div   _               (VInt x2)       = throw (Error ("type error: Div"))   --VErr("type error: Div")
evalOp Div   _               _               = throw (Error ("type error: Div"))   --VErr("type error: Div")

evalOp Lt    (VInt x1)       (VInt x2)       = VBool (x1<x2)
-- evalOp Lt    (VInt x1)       _               = throw (Error ("type error: Lt"))    --VErr("type error: Lt") 
-- evalOp Lt    _               (VInt x2)       = throw (Error ("type error: Lt"))    --VErr("type error: Lt") 
evalOp Lt    _               _               = throw (Error ("type error: Lt"))    --VErr("type error: Lt") 

evalOp Le    (VInt x1)       (VInt x2)       = VBool (x1<=x2)
-- evalOp Le    (VInt x1)       _               = throw (Error ("type error: Le"))    --VErr("type error: Le")
-- evalOp Le    _               (VInt x1)       = throw (Error ("type error: Le"))    --VErr("type error: Le")
evalOp Le    _               _               = throw (Error ("type error: Le"))    --VErr("type error: Le")

evalOp And   (VBool b1)      (VBool b2)      = VBool (b1&&b2)
-- evalOp And   (VBool b1)      _               = throw (Error ("type error: And"))   --VErr("type error: And")
-- evalOp And   _               (VBool b2)      = throw (Error ("type error: And"))   --VErr("type error: And")
evalOp And   _               _               = throw (Error ("type error: And"))   --VErr("type error: And")

evalOp Or    (VBool b1)      (VBool b2)      = VBool (b1||b2)
-- evalOp Or    (VBool b1)      _               = throw (Error ("type error: Or"))    --VErr("type error: Or")
-- evalOp Or    _               (VBool b2)      = throw (Error ("type error: Or"))    --VErr("type error: Or")
evalOp Or    _               _               = throw (Error ("type error: Or"))    --VErr("type error: Or")

evalOp Eq    (VInt x1)       (VInt x2)       = VBool (x1==x2)
evalOp Eq    (VBool x1)      (VBool x2)      = VBool (x1==x2)
evalOp Eq    (VNil)          (VNil)          = VBool True
evalOp Eq    (VPair x1 y1)   (VNil)          = VBool False
evalOp Eq    (VNil)          (VPair x1 y1)   = VBool False
evalOp Eq    (VPair x1 y1)   (VPair x2 y2)   = if (x1==x2) then (evalOp Eq y1 y2) else (VBool False)
evalOp Eq    _               _               = throw (Error ("type error: Eq"))    --VErr("type error: Eq")

evalOp Ne    (VInt x1)       (VInt x2)       = VBool (x1/=x2)
evalOp Ne    (VBool x1)      (VBool x2)      = VBool (x1/=x2)
evalOp Ne    (VNil)          (VNil)          = VBool False
evalOp Ne    (VPair x1 y1)   (VNil)          = VBool True
evalOp Ne    (VNil)          (VPair x1 y1)   = VBool True
evalOp Ne    (VPair x1 y1)   (VPair x2 y2)   = if (x1/=x2) then (evalOp Ne y1 y2) else (VBool False)
evalOp Ne    _               _               = throw (Error ("type error: Ne"))    --VErr("type error: Ne")

evalOp Cons  x               VNil            = (VPair x VNil)
evalOp Cons  x               (VPair a b)     = (VPair x (VPair a b))
evalOp Cons  _               _               = throw (Error ("type error: Cons"))  --VErr("type error: Cons")

--------------------------------------------------------------------------------
-- | `lookupId x env` returns the most recent
--   binding for the variable `x` (i.e. the first
--   from the left) in the list representing the
--   environment, and throws an `Error` otherwise.
--
-- >>> lookupId "z1" env0
-- 0
-- >>> lookupId "x" env0
-- 1
-- >>> lookupId "y" env0
-- 2
-- >>> lookupId "mickey" env0
-- *** Exception: Error {errMsg = "unbound variable: mickey"}
--------------------------------------------------------------------------------
lookupId :: Id -> Env -> Value
--------------------------------------------------------------------------------
{--
lookupId simply takes in an id and list of key-value pairs and returns the value assosciated with
  that key.
--}
lookupId key [] = throw (Error ("unbound variable: " ++ key))
lookupId key ((x, y):xs)
  | key == x = y
  | otherwise = lookupId key xs

{--
Prelude is where we can define functions that are needed. I suspect that this is where we 
  are going to have to define our head and tail functions for Problem 1, Part f.
--}
prelude :: Env
prelude =
  [ ("head", VPrim(\x -> case x of 
                  (VPair a b) -> a
                  _ -> throw(Error("type error: head"))))    --VErr("type error: head")))
                  ,
    ("tail", VPrim(\x -> case x of
                    (VPair a b) -> b
                    _ -> throw(Error("type error: tail"))))  --VErr("type error: tail"))) --
  ]

env0 :: Env
env0 =  [ ("z1", VInt 0)
        , ("x" , VInt 1)
        , ("y" , VInt 2)
        , ("z" , VInt 3)
        , ("z1", VInt 4)
        ]
--------------------------------------------------------------------------------