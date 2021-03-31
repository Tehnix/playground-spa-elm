-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.SearchResultItemEdge exposing (..)

import Api.GitHub.InputObject
import Api.GitHub.Interface
import Api.GitHub.Object
import Api.GitHub.Scalar
import Api.GitHub.ScalarCodecs
import Api.GitHub.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| A cursor for use in pagination.
-}
cursor : SelectionSet String Api.GitHub.Object.SearchResultItemEdge
cursor =
    Object.selectionForField "String" "cursor" [] Decode.string


{-| The item at the end of the edge.
-}
node : SelectionSet decodesTo Api.GitHub.Union.SearchResultItem -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.SearchResultItemEdge
node object_ =
    Object.selectionForCompositeField "node" [] object_ (identity >> Decode.nullable)


{-| Text matches on the result found.
-}
textMatches : SelectionSet decodesTo Api.GitHub.Object.TextMatch -> SelectionSet (Maybe (List (Maybe decodesTo))) Api.GitHub.Object.SearchResultItemEdge
textMatches object_ =
    Object.selectionForCompositeField "textMatches" [] object_ (identity >> Decode.nullable >> Decode.list >> Decode.nullable)