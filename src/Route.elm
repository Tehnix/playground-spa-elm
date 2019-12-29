module Route exposing (ItemParameters, Route(..), parser, title, toUrl)

import Url.Builder as UrlBuilder
import Url.Parser as UrlParser exposing ((<?>), oneOf, s)
import Url.Parser.Query as Query


{-| Our @Route@ data type defines all the routes of our application,
and sets up what data is relevant for each route to contain.

Adding a new route involves a couple of steps:

1.  Adding handling in the `parser`
2.  Expand `title` with a case for the new route
3.  Instructing `toUrl` how to convert the data type to a URL string

-}
type Route
    = Home
    | Item (Maybe ItemParameters)


type alias ItemParameters =
    { from : Maybe String
    , to : Maybe String
    }


{-| To go from an arbitrary @String@ into our @Route@ data type, we need
to instruct Elm how to parse our routes. We construct a parser, which will
return a @Maybe@ where @Nothing@ indicates no matches, and a @Just a@ means
that we have matched on something.

E.g.

    import Url.Parser as UrlParser
    UrlParser.parse parser "item?from=test"
    --> Just (Item "test")

Consult <https://package.elm-lang.org/packages/elm/url/latest/Url-Parser> for
more in-depth information.

-}
parser : UrlParser.Parser (Route -> a) a
parser =
    oneOf
        [ UrlParser.map Home UrlParser.top
        , UrlParser.map mkItem (s "item" <?> Query.string "from" <?> Query.string "to")
        ]


mkItem : Maybe String -> Maybe String -> Route
mkItem from to =
    Item (Just { from = from, to = to })


{-| Construct a title from our @Route@ object.

E.g.

    title (Just Home)
    --> "Home"

-}
title : Maybe Route -> String
title route =
    case route of
        Just Home ->
            "Home"

        Just (Item _) ->
            "Item"

        Nothing ->
            "Invalid route"


{-| Construct a title from our @Route@ object, and return an absolute
URL as a string to be used in as the href for a link.

E.g.

    toUrl <| Item (Just { from = Just "test", to = Nothing })
    --> "/item?from=test"

-}
toUrl : Route -> String
toUrl route =
    let
        -- Construct the query part from all values that are not `Nothing`.
        filterQuery : List ( String, Maybe String ) -> List UrlBuilder.QueryParameter
        filterQuery params =
            case params of
                [] ->
                    []

                ( name, Just value ) :: rest ->
                    UrlBuilder.string name value :: filterQuery rest

                ( _, Nothing ) :: rest ->
                    filterQuery rest
    in
    case route of
        Home ->
            UrlBuilder.absolute [] []

        Item params ->
            let
                query =
                    case params of
                        Just p ->
                            filterQuery [ ( "from", p.from ), ( "to", p.to ) ]

                        Nothing ->
                            []
            in
            UrlBuilder.absolute [ "item" ] query
