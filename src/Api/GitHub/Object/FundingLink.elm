-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.FundingLink exposing (..)

import Api.GitHub.Enum.FundingPlatform
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


{-| The funding platform this link is for.
-}
platform : SelectionSet Api.GitHub.Enum.FundingPlatform.FundingPlatform Api.GitHub.Object.FundingLink
platform =
    Object.selectionForField "Enum.FundingPlatform.FundingPlatform" "platform" [] Api.GitHub.Enum.FundingPlatform.decoder


{-| The configured URL for this funding link.
-}
url : SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.FundingLink
url =
    Object.selectionForField "ScalarCodecs.Uri" "url" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)