module VerifyExamples.Helper.Maybe.Maybe0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Helper.Maybe exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#maybe: \n\n    maybe \"nope\" (String.reverse) Nothing\n    --> \"nope\"" <|
        \() ->
            Expect.equal
                (
                maybe "nope" (String.reverse) Nothing
                )
                (
                "nope"
                )