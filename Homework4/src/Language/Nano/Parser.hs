{-# OPTIONS_GHC -w #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE PartialTypeSignatures #-}

module Language.Nano.Parser (
    parseExpr
  , parseTokens
  ) where

import Language.Nano.Lexer
import Language.Nano.Types hiding (Nano (..))
import Control.Monad.Except
import Control.Exception
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6 t7
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,419) ([52096,40961,0,4,0,256,0,0,0,40120,3071,16384,0,0,0,0,0,32768,459,160,0,0,0,1,0,1,47104,28,49162,229,208,59182,2815,0,8192,0,0,0,0,57344,65138,63,1024,0,7352,2560,60864,24572,0,18,0,0,32768,459,160,3676,1280,29408,10240,38656,16387,47105,28,49162,229,80,1838,640,14704,5120,52096,40961,23552,14,5,15872,4,61440,33,32768,271,0,2172,0,17376,0,1792,0,14336,0,0,0,0,8,0,64,0,64,0,64,0,1838,640,14704,5120,52096,49145,23552,14,5,0,0,0,0,7352,2560,0,0,0,17376,28672,65341,32791,63951,191,0,0,29408,10240,40704,32755,47105,28,49162,229,80,57344,67,256,1023,52096,40961,16384,65472,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_top","Top","Expr","IDs","List","let","true","false","in","if","then","else","TNUM","ID","'\\\\'","'->'","'='","'+'","'-'","'*'","'&&'","'||'","'=='","'/='","'<'","'<='","':'","'('","')'","'['","']'","','","%eof"]
        bit_start = st * 35
        bit_end = (st + 1) * 35
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..34]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (8) = happyShift action_5
action_0 (9) = happyShift action_6
action_0 (10) = happyShift action_7
action_0 (12) = happyShift action_8
action_0 (15) = happyShift action_9
action_0 (16) = happyShift action_10
action_0 (17) = happyShift action_11
action_0 (30) = happyShift action_12
action_0 (32) = happyShift action_13
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (16) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (19) = happyShift action_20
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (35) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (8) = happyShift action_5
action_4 (9) = happyShift action_6
action_4 (10) = happyShift action_7
action_4 (12) = happyShift action_8
action_4 (15) = happyShift action_9
action_4 (16) = happyShift action_16
action_4 (17) = happyShift action_11
action_4 (20) = happyShift action_24
action_4 (21) = happyShift action_25
action_4 (22) = happyShift action_26
action_4 (23) = happyShift action_27
action_4 (24) = happyShift action_28
action_4 (25) = happyShift action_29
action_4 (26) = happyShift action_30
action_4 (27) = happyShift action_31
action_4 (28) = happyShift action_32
action_4 (29) = happyShift action_33
action_4 (30) = happyShift action_12
action_4 (32) = happyShift action_13
action_4 (5) = happyGoto action_23
action_4 _ = happyReduce_2

action_5 (16) = happyShift action_22
action_5 _ = happyFail (happyExpListPerState 5)

action_6 _ = happyReduce_19

action_7 _ = happyReduce_20

action_8 (8) = happyShift action_5
action_8 (9) = happyShift action_6
action_8 (10) = happyShift action_7
action_8 (12) = happyShift action_8
action_8 (15) = happyShift action_9
action_8 (16) = happyShift action_16
action_8 (17) = happyShift action_11
action_8 (30) = happyShift action_12
action_8 (32) = happyShift action_13
action_8 (5) = happyGoto action_21
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_3

action_10 (19) = happyShift action_20
action_10 _ = happyReduce_4

action_11 (16) = happyShift action_19
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (8) = happyShift action_5
action_12 (9) = happyShift action_6
action_12 (10) = happyShift action_7
action_12 (12) = happyShift action_8
action_12 (15) = happyShift action_9
action_12 (16) = happyShift action_16
action_12 (17) = happyShift action_11
action_12 (30) = happyShift action_12
action_12 (32) = happyShift action_13
action_12 (5) = happyGoto action_18
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (8) = happyShift action_5
action_13 (9) = happyShift action_6
action_13 (10) = happyShift action_7
action_13 (12) = happyShift action_8
action_13 (15) = happyShift action_9
action_13 (16) = happyShift action_16
action_13 (17) = happyShift action_11
action_13 (30) = happyShift action_12
action_13 (32) = happyShift action_13
action_13 (33) = happyShift action_17
action_13 (5) = happyGoto action_14
action_13 (7) = happyGoto action_15
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (8) = happyShift action_5
action_14 (9) = happyShift action_6
action_14 (10) = happyShift action_7
action_14 (12) = happyShift action_8
action_14 (15) = happyShift action_9
action_14 (16) = happyShift action_16
action_14 (17) = happyShift action_11
action_14 (20) = happyShift action_24
action_14 (21) = happyShift action_25
action_14 (22) = happyShift action_26
action_14 (23) = happyShift action_27
action_14 (24) = happyShift action_28
action_14 (25) = happyShift action_29
action_14 (26) = happyShift action_30
action_14 (27) = happyShift action_31
action_14 (28) = happyShift action_32
action_14 (29) = happyShift action_33
action_14 (30) = happyShift action_12
action_14 (32) = happyShift action_13
action_14 (34) = happyShift action_52
action_14 (5) = happyGoto action_23
action_14 _ = happyReduce_28

action_15 (33) = happyShift action_51
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_4

action_17 _ = happyReduce_24

action_18 (8) = happyShift action_5
action_18 (9) = happyShift action_6
action_18 (10) = happyShift action_7
action_18 (12) = happyShift action_8
action_18 (15) = happyShift action_9
action_18 (16) = happyShift action_16
action_18 (17) = happyShift action_11
action_18 (20) = happyShift action_24
action_18 (21) = happyShift action_25
action_18 (22) = happyShift action_26
action_18 (23) = happyShift action_27
action_18 (24) = happyShift action_28
action_18 (25) = happyShift action_29
action_18 (26) = happyShift action_30
action_18 (27) = happyShift action_31
action_18 (28) = happyShift action_32
action_18 (29) = happyShift action_33
action_18 (30) = happyShift action_12
action_18 (31) = happyShift action_50
action_18 (32) = happyShift action_13
action_18 (5) = happyGoto action_23
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (18) = happyShift action_49
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (8) = happyShift action_5
action_20 (9) = happyShift action_6
action_20 (10) = happyShift action_7
action_20 (12) = happyShift action_8
action_20 (15) = happyShift action_9
action_20 (16) = happyShift action_16
action_20 (17) = happyShift action_11
action_20 (30) = happyShift action_12
action_20 (32) = happyShift action_13
action_20 (5) = happyGoto action_48
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (8) = happyShift action_5
action_21 (9) = happyShift action_6
action_21 (10) = happyShift action_7
action_21 (12) = happyShift action_8
action_21 (13) = happyShift action_47
action_21 (15) = happyShift action_9
action_21 (16) = happyShift action_16
action_21 (17) = happyShift action_11
action_21 (20) = happyShift action_24
action_21 (21) = happyShift action_25
action_21 (22) = happyShift action_26
action_21 (23) = happyShift action_27
action_21 (24) = happyShift action_28
action_21 (25) = happyShift action_29
action_21 (26) = happyShift action_30
action_21 (27) = happyShift action_31
action_21 (28) = happyShift action_32
action_21 (29) = happyShift action_33
action_21 (30) = happyShift action_12
action_21 (32) = happyShift action_13
action_21 (5) = happyGoto action_23
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (16) = happyShift action_45
action_22 (19) = happyShift action_46
action_22 (6) = happyGoto action_44
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (8) = happyShift action_5
action_23 (9) = happyShift action_6
action_23 (10) = happyShift action_7
action_23 (12) = happyShift action_8
action_23 (15) = happyShift action_9
action_23 (16) = happyShift action_16
action_23 (17) = happyShift action_11
action_23 (20) = happyShift action_24
action_23 (21) = happyShift action_25
action_23 (22) = happyShift action_26
action_23 (23) = happyShift action_27
action_23 (24) = happyShift action_28
action_23 (25) = happyShift action_29
action_23 (26) = happyShift action_30
action_23 (27) = happyShift action_31
action_23 (28) = happyShift action_32
action_23 (29) = happyShift action_33
action_23 (30) = happyShift action_12
action_23 (32) = happyShift action_13
action_23 (5) = happyGoto action_23
action_23 _ = happyReduce_21

action_24 (8) = happyShift action_5
action_24 (9) = happyShift action_6
action_24 (10) = happyShift action_7
action_24 (12) = happyShift action_8
action_24 (15) = happyShift action_9
action_24 (16) = happyShift action_16
action_24 (17) = happyShift action_11
action_24 (30) = happyShift action_12
action_24 (32) = happyShift action_13
action_24 (5) = happyGoto action_43
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (8) = happyShift action_5
action_25 (9) = happyShift action_6
action_25 (10) = happyShift action_7
action_25 (12) = happyShift action_8
action_25 (15) = happyShift action_9
action_25 (16) = happyShift action_16
action_25 (17) = happyShift action_11
action_25 (30) = happyShift action_12
action_25 (32) = happyShift action_13
action_25 (5) = happyGoto action_42
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (8) = happyShift action_5
action_26 (9) = happyShift action_6
action_26 (10) = happyShift action_7
action_26 (12) = happyShift action_8
action_26 (15) = happyShift action_9
action_26 (16) = happyShift action_16
action_26 (17) = happyShift action_11
action_26 (30) = happyShift action_12
action_26 (32) = happyShift action_13
action_26 (5) = happyGoto action_41
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (8) = happyShift action_5
action_27 (9) = happyShift action_6
action_27 (10) = happyShift action_7
action_27 (12) = happyShift action_8
action_27 (15) = happyShift action_9
action_27 (16) = happyShift action_16
action_27 (17) = happyShift action_11
action_27 (30) = happyShift action_12
action_27 (32) = happyShift action_13
action_27 (5) = happyGoto action_40
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (8) = happyShift action_5
action_28 (9) = happyShift action_6
action_28 (10) = happyShift action_7
action_28 (12) = happyShift action_8
action_28 (15) = happyShift action_9
action_28 (16) = happyShift action_16
action_28 (17) = happyShift action_11
action_28 (30) = happyShift action_12
action_28 (32) = happyShift action_13
action_28 (5) = happyGoto action_39
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (8) = happyShift action_5
action_29 (9) = happyShift action_6
action_29 (10) = happyShift action_7
action_29 (12) = happyShift action_8
action_29 (15) = happyShift action_9
action_29 (16) = happyShift action_16
action_29 (17) = happyShift action_11
action_29 (30) = happyShift action_12
action_29 (32) = happyShift action_13
action_29 (5) = happyGoto action_38
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (8) = happyShift action_5
action_30 (9) = happyShift action_6
action_30 (10) = happyShift action_7
action_30 (12) = happyShift action_8
action_30 (15) = happyShift action_9
action_30 (16) = happyShift action_16
action_30 (17) = happyShift action_11
action_30 (30) = happyShift action_12
action_30 (32) = happyShift action_13
action_30 (5) = happyGoto action_37
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (8) = happyShift action_5
action_31 (9) = happyShift action_6
action_31 (10) = happyShift action_7
action_31 (12) = happyShift action_8
action_31 (15) = happyShift action_9
action_31 (16) = happyShift action_16
action_31 (17) = happyShift action_11
action_31 (30) = happyShift action_12
action_31 (32) = happyShift action_13
action_31 (5) = happyGoto action_36
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (8) = happyShift action_5
action_32 (9) = happyShift action_6
action_32 (10) = happyShift action_7
action_32 (12) = happyShift action_8
action_32 (15) = happyShift action_9
action_32 (16) = happyShift action_16
action_32 (17) = happyShift action_11
action_32 (30) = happyShift action_12
action_32 (32) = happyShift action_13
action_32 (5) = happyGoto action_35
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (8) = happyShift action_5
action_33 (9) = happyShift action_6
action_33 (10) = happyShift action_7
action_33 (12) = happyShift action_8
action_33 (15) = happyShift action_9
action_33 (16) = happyShift action_16
action_33 (17) = happyShift action_11
action_33 (30) = happyShift action_12
action_33 (32) = happyShift action_13
action_33 (5) = happyGoto action_34
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (8) = happyShift action_5
action_34 (9) = happyShift action_6
action_34 (10) = happyShift action_7
action_34 (15) = happyShift action_9
action_34 (16) = happyShift action_16
action_34 (17) = happyShift action_11
action_34 (20) = happyShift action_24
action_34 (21) = happyShift action_25
action_34 (22) = happyShift action_26
action_34 (23) = happyShift action_27
action_34 (24) = happyShift action_28
action_34 (29) = happyShift action_33
action_34 (30) = happyShift action_12
action_34 (32) = happyShift action_13
action_34 (5) = happyGoto action_23
action_34 _ = happyReduce_22

action_35 (8) = happyShift action_5
action_35 (9) = happyShift action_6
action_35 (10) = happyShift action_7
action_35 (12) = happyFail []
action_35 (15) = happyShift action_9
action_35 (16) = happyShift action_16
action_35 (17) = happyShift action_11
action_35 (20) = happyShift action_24
action_35 (21) = happyShift action_25
action_35 (22) = happyShift action_26
action_35 (23) = happyShift action_27
action_35 (24) = happyShift action_28
action_35 (25) = happyFail []
action_35 (26) = happyFail []
action_35 (27) = happyFail []
action_35 (28) = happyFail []
action_35 (29) = happyShift action_33
action_35 (30) = happyShift action_12
action_35 (32) = happyShift action_13
action_35 (5) = happyGoto action_23
action_35 _ = happyReduce_15

action_36 (8) = happyShift action_5
action_36 (9) = happyShift action_6
action_36 (10) = happyShift action_7
action_36 (12) = happyFail []
action_36 (15) = happyShift action_9
action_36 (16) = happyShift action_16
action_36 (17) = happyShift action_11
action_36 (20) = happyShift action_24
action_36 (21) = happyShift action_25
action_36 (22) = happyShift action_26
action_36 (23) = happyShift action_27
action_36 (24) = happyShift action_28
action_36 (25) = happyFail []
action_36 (26) = happyFail []
action_36 (27) = happyFail []
action_36 (28) = happyFail []
action_36 (29) = happyShift action_33
action_36 (30) = happyShift action_12
action_36 (32) = happyShift action_13
action_36 (5) = happyGoto action_23
action_36 _ = happyReduce_14

action_37 (8) = happyShift action_5
action_37 (9) = happyShift action_6
action_37 (10) = happyShift action_7
action_37 (12) = happyFail []
action_37 (15) = happyShift action_9
action_37 (16) = happyShift action_16
action_37 (17) = happyShift action_11
action_37 (20) = happyShift action_24
action_37 (21) = happyShift action_25
action_37 (22) = happyShift action_26
action_37 (23) = happyShift action_27
action_37 (24) = happyShift action_28
action_37 (25) = happyFail []
action_37 (26) = happyFail []
action_37 (27) = happyFail []
action_37 (28) = happyFail []
action_37 (29) = happyShift action_33
action_37 (30) = happyShift action_12
action_37 (32) = happyShift action_13
action_37 (5) = happyGoto action_23
action_37 _ = happyReduce_13

action_38 (8) = happyShift action_5
action_38 (9) = happyShift action_6
action_38 (10) = happyShift action_7
action_38 (12) = happyFail []
action_38 (15) = happyShift action_9
action_38 (16) = happyShift action_16
action_38 (17) = happyShift action_11
action_38 (20) = happyShift action_24
action_38 (21) = happyShift action_25
action_38 (22) = happyShift action_26
action_38 (23) = happyShift action_27
action_38 (24) = happyShift action_28
action_38 (25) = happyFail []
action_38 (26) = happyFail []
action_38 (27) = happyFail []
action_38 (28) = happyFail []
action_38 (29) = happyShift action_33
action_38 (30) = happyShift action_12
action_38 (32) = happyShift action_13
action_38 (5) = happyGoto action_23
action_38 _ = happyReduce_12

action_39 (8) = happyShift action_5
action_39 (9) = happyShift action_6
action_39 (10) = happyShift action_7
action_39 (15) = happyShift action_9
action_39 (16) = happyShift action_16
action_39 (17) = happyShift action_11
action_39 (20) = happyShift action_24
action_39 (21) = happyShift action_25
action_39 (22) = happyShift action_26
action_39 (30) = happyShift action_12
action_39 (32) = happyShift action_13
action_39 (5) = happyGoto action_23
action_39 _ = happyReduce_17

action_40 (8) = happyShift action_5
action_40 (9) = happyShift action_6
action_40 (10) = happyShift action_7
action_40 (15) = happyShift action_9
action_40 (16) = happyShift action_16
action_40 (17) = happyShift action_11
action_40 (20) = happyShift action_24
action_40 (21) = happyShift action_25
action_40 (22) = happyShift action_26
action_40 (30) = happyShift action_12
action_40 (32) = happyShift action_13
action_40 (5) = happyGoto action_23
action_40 _ = happyReduce_16

action_41 (8) = happyShift action_5
action_41 (9) = happyShift action_6
action_41 (10) = happyShift action_7
action_41 (15) = happyShift action_9
action_41 (16) = happyShift action_16
action_41 (17) = happyShift action_11
action_41 (30) = happyShift action_12
action_41 (32) = happyShift action_13
action_41 (5) = happyGoto action_23
action_41 _ = happyReduce_9

action_42 (8) = happyShift action_5
action_42 (9) = happyShift action_6
action_42 (10) = happyShift action_7
action_42 (15) = happyShift action_9
action_42 (16) = happyShift action_16
action_42 (17) = happyShift action_11
action_42 (22) = happyShift action_26
action_42 (30) = happyShift action_12
action_42 (32) = happyShift action_13
action_42 (5) = happyGoto action_23
action_42 _ = happyReduce_11

action_43 (8) = happyShift action_5
action_43 (9) = happyShift action_6
action_43 (10) = happyShift action_7
action_43 (15) = happyShift action_9
action_43 (16) = happyShift action_16
action_43 (17) = happyShift action_11
action_43 (22) = happyShift action_26
action_43 (30) = happyShift action_12
action_43 (32) = happyShift action_13
action_43 (5) = happyGoto action_23
action_43 _ = happyReduce_10

action_44 (19) = happyShift action_58
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (16) = happyShift action_45
action_45 (6) = happyGoto action_57
action_45 _ = happyReduce_25

action_46 (8) = happyShift action_5
action_46 (9) = happyShift action_6
action_46 (10) = happyShift action_7
action_46 (12) = happyShift action_8
action_46 (15) = happyShift action_9
action_46 (16) = happyShift action_16
action_46 (17) = happyShift action_11
action_46 (30) = happyShift action_12
action_46 (32) = happyShift action_13
action_46 (5) = happyGoto action_56
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (8) = happyShift action_5
action_47 (9) = happyShift action_6
action_47 (10) = happyShift action_7
action_47 (12) = happyShift action_8
action_47 (15) = happyShift action_9
action_47 (16) = happyShift action_16
action_47 (17) = happyShift action_11
action_47 (30) = happyShift action_12
action_47 (32) = happyShift action_13
action_47 (5) = happyGoto action_55
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (8) = happyShift action_5
action_48 (9) = happyShift action_6
action_48 (10) = happyShift action_7
action_48 (12) = happyShift action_8
action_48 (15) = happyShift action_9
action_48 (16) = happyShift action_16
action_48 (17) = happyShift action_11
action_48 (20) = happyShift action_24
action_48 (21) = happyShift action_25
action_48 (22) = happyShift action_26
action_48 (23) = happyShift action_27
action_48 (24) = happyShift action_28
action_48 (25) = happyShift action_29
action_48 (26) = happyShift action_30
action_48 (27) = happyShift action_31
action_48 (28) = happyShift action_32
action_48 (29) = happyShift action_33
action_48 (30) = happyShift action_12
action_48 (32) = happyShift action_13
action_48 (5) = happyGoto action_23
action_48 _ = happyReduce_1

action_49 (8) = happyShift action_5
action_49 (9) = happyShift action_6
action_49 (10) = happyShift action_7
action_49 (12) = happyShift action_8
action_49 (15) = happyShift action_9
action_49 (16) = happyShift action_16
action_49 (17) = happyShift action_11
action_49 (30) = happyShift action_12
action_49 (32) = happyShift action_13
action_49 (5) = happyGoto action_54
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_18

action_51 _ = happyReduce_23

action_52 (8) = happyShift action_5
action_52 (9) = happyShift action_6
action_52 (10) = happyShift action_7
action_52 (12) = happyShift action_8
action_52 (15) = happyShift action_9
action_52 (16) = happyShift action_16
action_52 (17) = happyShift action_11
action_52 (30) = happyShift action_12
action_52 (32) = happyShift action_13
action_52 (5) = happyGoto action_14
action_52 (7) = happyGoto action_53
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_27

action_54 (8) = happyShift action_5
action_54 (9) = happyShift action_6
action_54 (10) = happyShift action_7
action_54 (15) = happyShift action_9
action_54 (16) = happyShift action_16
action_54 (17) = happyShift action_11
action_54 (20) = happyShift action_24
action_54 (21) = happyShift action_25
action_54 (22) = happyShift action_26
action_54 (23) = happyShift action_27
action_54 (24) = happyShift action_28
action_54 (29) = happyShift action_33
action_54 (30) = happyShift action_12
action_54 (32) = happyShift action_13
action_54 (5) = happyGoto action_23
action_54 _ = happyReduce_7

action_55 (8) = happyShift action_5
action_55 (9) = happyShift action_6
action_55 (10) = happyShift action_7
action_55 (12) = happyShift action_8
action_55 (14) = happyShift action_61
action_55 (15) = happyShift action_9
action_55 (16) = happyShift action_16
action_55 (17) = happyShift action_11
action_55 (20) = happyShift action_24
action_55 (21) = happyShift action_25
action_55 (22) = happyShift action_26
action_55 (23) = happyShift action_27
action_55 (24) = happyShift action_28
action_55 (25) = happyShift action_29
action_55 (26) = happyShift action_30
action_55 (27) = happyShift action_31
action_55 (28) = happyShift action_32
action_55 (29) = happyShift action_33
action_55 (30) = happyShift action_12
action_55 (32) = happyShift action_13
action_55 (5) = happyGoto action_23
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (8) = happyShift action_5
action_56 (9) = happyShift action_6
action_56 (10) = happyShift action_7
action_56 (11) = happyShift action_60
action_56 (12) = happyShift action_8
action_56 (15) = happyShift action_9
action_56 (16) = happyShift action_16
action_56 (17) = happyShift action_11
action_56 (20) = happyShift action_24
action_56 (21) = happyShift action_25
action_56 (22) = happyShift action_26
action_56 (23) = happyShift action_27
action_56 (24) = happyShift action_28
action_56 (25) = happyShift action_29
action_56 (26) = happyShift action_30
action_56 (27) = happyShift action_31
action_56 (28) = happyShift action_32
action_56 (29) = happyShift action_33
action_56 (30) = happyShift action_12
action_56 (32) = happyShift action_13
action_56 (5) = happyGoto action_23
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_26

action_58 (8) = happyShift action_5
action_58 (9) = happyShift action_6
action_58 (10) = happyShift action_7
action_58 (12) = happyShift action_8
action_58 (15) = happyShift action_9
action_58 (16) = happyShift action_16
action_58 (17) = happyShift action_11
action_58 (30) = happyShift action_12
action_58 (32) = happyShift action_13
action_58 (5) = happyGoto action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (8) = happyShift action_5
action_59 (9) = happyShift action_6
action_59 (10) = happyShift action_7
action_59 (11) = happyShift action_64
action_59 (12) = happyShift action_8
action_59 (15) = happyShift action_9
action_59 (16) = happyShift action_16
action_59 (17) = happyShift action_11
action_59 (20) = happyShift action_24
action_59 (21) = happyShift action_25
action_59 (22) = happyShift action_26
action_59 (23) = happyShift action_27
action_59 (24) = happyShift action_28
action_59 (25) = happyShift action_29
action_59 (26) = happyShift action_30
action_59 (27) = happyShift action_31
action_59 (28) = happyShift action_32
action_59 (29) = happyShift action_33
action_59 (30) = happyShift action_12
action_59 (32) = happyShift action_13
action_59 (5) = happyGoto action_23
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (8) = happyShift action_5
action_60 (9) = happyShift action_6
action_60 (10) = happyShift action_7
action_60 (12) = happyShift action_8
action_60 (15) = happyShift action_9
action_60 (16) = happyShift action_16
action_60 (17) = happyShift action_11
action_60 (30) = happyShift action_12
action_60 (32) = happyShift action_13
action_60 (5) = happyGoto action_63
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (8) = happyShift action_5
action_61 (9) = happyShift action_6
action_61 (10) = happyShift action_7
action_61 (12) = happyShift action_8
action_61 (15) = happyShift action_9
action_61 (16) = happyShift action_16
action_61 (17) = happyShift action_11
action_61 (30) = happyShift action_12
action_61 (32) = happyShift action_13
action_61 (5) = happyGoto action_62
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (8) = happyShift action_5
action_62 (9) = happyShift action_6
action_62 (10) = happyShift action_7
action_62 (12) = happyFail []
action_62 (15) = happyShift action_9
action_62 (16) = happyShift action_16
action_62 (17) = happyShift action_11
action_62 (20) = happyShift action_24
action_62 (21) = happyShift action_25
action_62 (22) = happyShift action_26
action_62 (23) = happyShift action_27
action_62 (24) = happyShift action_28
action_62 (25) = happyFail []
action_62 (26) = happyFail []
action_62 (27) = happyFail []
action_62 (28) = happyFail []
action_62 (29) = happyShift action_33
action_62 (30) = happyShift action_12
action_62 (32) = happyShift action_13
action_62 (5) = happyGoto action_23
action_62 _ = happyReduce_8

action_63 (8) = happyShift action_5
action_63 (9) = happyShift action_6
action_63 (10) = happyShift action_7
action_63 (12) = happyShift action_8
action_63 (15) = happyShift action_9
action_63 (16) = happyShift action_16
action_63 (17) = happyShift action_11
action_63 (20) = happyShift action_24
action_63 (21) = happyShift action_25
action_63 (22) = happyShift action_26
action_63 (23) = happyShift action_27
action_63 (24) = happyShift action_28
action_63 (25) = happyShift action_29
action_63 (26) = happyShift action_30
action_63 (27) = happyShift action_31
action_63 (28) = happyShift action_32
action_63 (29) = happyShift action_33
action_63 (30) = happyShift action_12
action_63 (32) = happyShift action_13
action_63 (5) = happyGoto action_23
action_63 _ = happyReduce_5

action_64 (8) = happyShift action_5
action_64 (9) = happyShift action_6
action_64 (10) = happyShift action_7
action_64 (12) = happyShift action_8
action_64 (15) = happyShift action_9
action_64 (16) = happyShift action_16
action_64 (17) = happyShift action_11
action_64 (30) = happyShift action_12
action_64 (32) = happyShift action_13
action_64 (5) = happyGoto action_65
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (8) = happyShift action_5
action_65 (9) = happyShift action_6
action_65 (10) = happyShift action_7
action_65 (12) = happyShift action_8
action_65 (15) = happyShift action_9
action_65 (16) = happyShift action_16
action_65 (17) = happyShift action_11
action_65 (20) = happyShift action_24
action_65 (21) = happyShift action_25
action_65 (22) = happyShift action_26
action_65 (23) = happyShift action_27
action_65 (24) = happyShift action_28
action_65 (25) = happyShift action_29
action_65 (26) = happyShift action_30
action_65 (27) = happyShift action_31
action_65 (28) = happyShift action_32
action_65 (29) = happyShift action_33
action_65 (30) = happyShift action_12
action_65 (32) = happyShift action_13
action_65 (5) = happyGoto action_23
action_65 _ = happyReduce_6

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_3)
	_
	_
	 =  HappyAbsSyn4
		 (happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyTerminal (NUM _ happy_var_1))
	 =  HappyAbsSyn5
		 (EInt       happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyTerminal (ID _ happy_var_1))
	 =  HappyAbsSyn5
		 (EVar       happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 5 happyReduction_5
happyReduction_5 ((HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ELet       happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 7 5 happyReduction_6
happyReduction_6 ((HappyAbsSyn5  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyTerminal (ID _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ELet       happy_var_2 (mkLam happy_var_3 happy_var_5) happy_var_7
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 4 5 happyReduction_7
happyReduction_7 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ELam       happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 6 5 happyReduction_8
happyReduction_8 ((HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (EIf        happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Mul   happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Plus  happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Minus happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  5 happyReduction_12
happyReduction_12 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Eq    happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Ne    happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  5 happyReduction_14
happyReduction_14 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Lt    happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  5 happyReduction_15
happyReduction_15 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Le    happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  5 happyReduction_16
happyReduction_16 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin And   happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  5 happyReduction_17
happyReduction_17 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Or    happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  5 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  5 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn5
		 (EBool True
	)

happyReduce_20 = happySpecReduce_1  5 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn5
		 (EBool False
	)

happyReduce_21 = happySpecReduce_2  5 happyReduction_21
happyReduction_21 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EApp happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  5 happyReduction_22
happyReduction_22 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (EBin Cons  happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  5 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  5 happyReduction_24
happyReduction_24 _
	_
	 =  HappyAbsSyn5
		 (ENil
	)

happyReduce_25 = happySpecReduce_1  6 happyReduction_25
happyReduction_25 (HappyTerminal (ID _ happy_var_1))
	 =  HappyAbsSyn6
		 ([ happy_var_1 ]
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  6 happyReduction_26
happyReduction_26 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (ID _ happy_var_1))
	 =  HappyAbsSyn6
		 ((happy_var_1):(happy_var_2)
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  7 happyReduction_27
happyReduction_27 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (EBin Cons (happy_var_1) (happy_var_3)
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  7 happyReduction_28
happyReduction_28 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (EBin Cons (happy_var_1) ENil
	)
happyReduction_28 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 35 35 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	LET _ -> cont 8;
	TRUE _ -> cont 9;
	FALSE _ -> cont 10;
	IN _ -> cont 11;
	IF _ -> cont 12;
	THEN _ -> cont 13;
	ELSE _ -> cont 14;
	NUM _ happy_dollar_dollar -> cont 15;
	ID _ happy_dollar_dollar -> cont 16;
	LAM _ -> cont 17;
	ARROW _ -> cont 18;
	EQB _ -> cont 19;
	PLUS _ -> cont 20;
	MINUS _ -> cont 21;
	MUL _ -> cont 22;
	AND _ -> cont 23;
	OR  _ -> cont 24;
	EQL _ -> cont 25;
	NEQ _ -> cont 26;
	LESS _ -> cont 27;
	LEQ _ -> cont 28;
	COLON _ -> cont 29;
	LPAREN _ -> cont 30;
	RPAREN _ -> cont 31;
	LBRAC _ -> cont 32;
	RBRAC _ -> cont 33;
	COMMA _ -> cont 34;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 35 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Except String a -> (a -> Except String b) -> Except String b
happyThen = ((>>=))
happyReturn :: () => a -> Except String a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Except String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Except String a
happyError' = (\(tokens, _) -> parseError tokens)
top tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


mkLam :: [Id] -> Expr -> Expr
mkLam []     e = e
mkLam (x:xs) e = ELam x (mkLam xs e)

parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError []     = throwError "Unexpected end of Input"

parseExpr :: String -> Expr
parseExpr s = case parseExpr' s of
                Left msg -> throw (Error ("parse error:" ++ msg))
                Right e  -> e

parseExpr' input = runExcept $ do
   tokenStream <- scanTokens input
   top tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}

















































































































































































































-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 











data Happy_IntList = HappyCons Int Happy_IntList




















infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action




indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

