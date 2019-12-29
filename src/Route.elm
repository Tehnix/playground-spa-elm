module Route exposing (Route(..), routeParser, routeTitle)

import Url.Parser as UrlParser exposing ((<?>), oneOf, s, string)
import Url.Parser.Query as Query


{-| Our @Route@ data type defines all the routes of our application,
and sets up what data is relevant for each route to contain.
-}
type Route
    = Home
    | Item (Maybe String)


{-| To go from an arbitrary @String@ into our @Route@ data type, we need
to instruct Elm how to parse our routes. We construct a parser, which will
return a @Maybe@ where @Nothing@ indicates no matches, and a @Just a@ means
that we have matched on something.

E.g.

"" ==> Just Home
"item/test" ==> Just (Item "test")
"item" ==> Nothing
"never/test" ==> Nothing

Consult <https://package.elm-lang.org/packages/elm/url/latest/Url-Parser> for
more in-depth information.

-}
routeParser : UrlParser.Parser (Route -> a) a
routeParser =
    oneOf
        [ UrlParser.map Home UrlParser.top
        , UrlParser.map Item (s "item" <?> Query.string "from")
        ]


{-| Construct a title from our @Route@ object.

E.g.

    routeTitle (Just Home)
    --> "Home"

-}
routeTitle : Maybe Route -> String
routeTitle route =
    case route of
        Just Home ->
            "Home"

        Just (Item from) ->
            case from of
                Just f ->
                    "Item: " ++ f

                Nothing ->
                    "Item"

        Nothing ->
            "Invalid route"
