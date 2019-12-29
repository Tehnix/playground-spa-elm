module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (Test, test)


suite : Test
suite =
    test "Implement our first test. See https://package.elm-lang.org/packages/elm-explorations/test/latest for how to do this!" <|
        \_ -> 1 + 1 |> Expect.equal 2
