-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.LanguageEdge exposing (..)

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


cursor : SelectionSet String Api.GitHub.Object.LanguageEdge
cursor =
    Object.selectionForField "String" "cursor" [] Decode.string


node : SelectionSet decodesTo Api.GitHub.Object.Language -> SelectionSet decodesTo Api.GitHub.Object.LanguageEdge
node object_ =
    Object.selectionForCompositeField "node" [] object_ identity


{-| The number of bytes of code written in the language.
-}
size : SelectionSet Int Api.GitHub.Object.LanguageEdge
size =
    Object.selectionForField "Int" "size" [] Decode.int