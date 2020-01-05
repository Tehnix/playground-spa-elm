module Helper.Route exposing (toUrl)

import Application.Route exposing (Route(..))
import Helper.Maybe exposing (maybe)
import Url.Builder as UrlBuilder


{-| Construct a title from our @Route@ object, and return an absolute
URL as a string to be used in as the href for a link.

E.g.

    toUrl <| Item (Just { from = Just "test", to = Nothing })
    --> "/item?from=test"

When adding a new route, you will want to specify how to convert it to
an URL string.

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
            UrlBuilder.absolute [ "item" ] <|
                maybe [] (\p -> filterQuery [ ( "from", p.from ), ( "to", p.to ) ]) params
