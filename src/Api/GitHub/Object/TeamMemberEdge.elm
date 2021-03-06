-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.TeamMemberEdge exposing (..)

import Api.GitHub.Enum.TeamMemberRole
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
cursor : SelectionSet String Api.GitHub.Object.TeamMemberEdge
cursor =
    Object.selectionForField "String" "cursor" [] Decode.string


{-| The HTTP path to the organization's member access page.
-}
memberAccessResourcePath : SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.TeamMemberEdge
memberAccessResourcePath =
    Object.selectionForField "ScalarCodecs.Uri" "memberAccessResourcePath" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| The HTTP URL to the organization's member access page.
-}
memberAccessUrl : SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.TeamMemberEdge
memberAccessUrl =
    Object.selectionForField "ScalarCodecs.Uri" "memberAccessUrl" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)


node : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet decodesTo Api.GitHub.Object.TeamMemberEdge
node object_ =
    Object.selectionForCompositeField "node" [] object_ identity


{-| The role the member has on the team.
-}
role : SelectionSet Api.GitHub.Enum.TeamMemberRole.TeamMemberRole Api.GitHub.Object.TeamMemberEdge
role =
    Object.selectionForField "Enum.TeamMemberRole.TeamMemberRole" "role" [] Api.GitHub.Enum.TeamMemberRole.decoder
