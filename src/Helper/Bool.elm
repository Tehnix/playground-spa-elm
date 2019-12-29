module Helper.Bool exposing (bool, when)

{-| Helper functions for working with `Bool` types.
-}


{-| Run a function on an item, if the condition is true, else return the
same item again.

E.g.

    when True (String.reverse) "yes"
    --> "sey"

    when False (String.reverse) "nope"
    --> "nope"

-}
when : Bool -> (a -> a) -> a -> a
when condition f a =
    if condition then
        f a

    else
        identity a


{-| A port of Haskell's `maybe` function.

This is really just a shorthand for if c then y else z.

E.g.

    bool "nope" "yes" True
    --> "yes"

    bool "nope" "yes" False
    --> "nope"

-}
bool : a -> a -> Bool -> a
bool f t condition =
    if condition then
        t

    else
        f
