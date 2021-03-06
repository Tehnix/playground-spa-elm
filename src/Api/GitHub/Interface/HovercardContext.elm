-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Interface.HovercardContext exposing (..)

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
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode


type alias Fragments decodesTo =
    { onGenericHovercardContext : SelectionSet decodesTo Api.GitHub.Object.GenericHovercardContext
    , onOrganizationTeamsHovercardContext : SelectionSet decodesTo Api.GitHub.Object.OrganizationTeamsHovercardContext
    , onOrganizationsHovercardContext : SelectionSet decodesTo Api.GitHub.Object.OrganizationsHovercardContext
    , onReviewStatusHovercardContext : SelectionSet decodesTo Api.GitHub.Object.ReviewStatusHovercardContext
    , onViewerHovercardContext : SelectionSet decodesTo Api.GitHub.Object.ViewerHovercardContext
    }


{-| Build an exhaustive selection of type-specific fragments.
-}
fragments :
    Fragments decodesTo
    -> SelectionSet decodesTo Api.GitHub.Interface.HovercardContext
fragments selections =
    Object.exhaustiveFragmentSelection
        [ Object.buildFragment "GenericHovercardContext" selections.onGenericHovercardContext
        , Object.buildFragment "OrganizationTeamsHovercardContext" selections.onOrganizationTeamsHovercardContext
        , Object.buildFragment "OrganizationsHovercardContext" selections.onOrganizationsHovercardContext
        , Object.buildFragment "ReviewStatusHovercardContext" selections.onReviewStatusHovercardContext
        , Object.buildFragment "ViewerHovercardContext" selections.onViewerHovercardContext
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    { onGenericHovercardContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onOrganizationTeamsHovercardContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onOrganizationsHovercardContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewStatusHovercardContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onViewerHovercardContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }


{-| A string describing this context
-}
message : SelectionSet String Api.GitHub.Interface.HovercardContext
message =
    Object.selectionForField "String" "message" [] Decode.string


{-| An octicon to accompany this context
-}
octicon : SelectionSet String Api.GitHub.Interface.HovercardContext
octicon =
    Object.selectionForField "String" "octicon" [] Decode.string
