module Helper.Maybe exposing (maybe, maybeAlt)

{-| Helper functions for working with `Maybe` types.
-}


{-| A port of Haskell's `maybe` function.

The `maybe` function takes a default value, a function, and a `Maybe`
value. If the `Maybe` value is `Nothing`, the function returns the
default value. Otherwise, it applies the function to the value inside
the `Just` and returns the result.

E.g.

    maybe "nope" (String.reverse) (Just "yes")
    --> "sey"

    maybe "nope" (String.reverse) Nothing
    --> "nope"

-}
maybe : b -> (a -> b) -> Maybe a -> b
maybe defaultValue f maybeValue =
    case maybeValue of
        Just value ->
            f value

        Nothing ->
            defaultValue


{-| Exactly like `maybe`, but with the function as the last argument.

The `maybeAlt` function takes a default value, a function, and a `Maybe`
value. If the `Maybe` value is `Nothing`, the function returns the
default value. Otherwise, it applies the function to the value inside
the `Just` and returns the result.

E.g.

    maybeAlt "nope" (Just "yes") (String.reverse)
    --> "sey"

    maybeAlt "nope" Nothing (String.reverse)
    --> "nope"

-}
maybeAlt : b -> Maybe a -> (a -> b) -> b
maybeAlt defaultValue maybeValue f =
    maybe defaultValue f maybeValue
