-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.UserBlockedEvent exposing (..)

import Api.GitHub.Enum.UserBlockDuration
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


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet decodesTo Api.GitHub.Interface.Actor -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.UserBlockedEvent
actor object_ =
    Object.selectionForCompositeField "actor" [] object_ (identity >> Decode.nullable)


{-| Number of days that the user was blocked for.
-}
blockDuration : SelectionSet Api.GitHub.Enum.UserBlockDuration.UserBlockDuration Api.GitHub.Object.UserBlockedEvent
blockDuration =
    Object.selectionForField "Enum.UserBlockDuration.UserBlockDuration" "blockDuration" [] Api.GitHub.Enum.UserBlockDuration.decoder


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Api.GitHub.ScalarCodecs.DateTime Api.GitHub.Object.UserBlockedEvent
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.UserBlockedEvent
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The user who was blocked.
-}
subject : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.UserBlockedEvent
subject object_ =
    Object.selectionForCompositeField "subject" [] object_ (identity >> Decode.nullable)
