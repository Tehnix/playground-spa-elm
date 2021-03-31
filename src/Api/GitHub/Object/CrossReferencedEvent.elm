-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.CrossReferencedEvent exposing (..)

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
actor : SelectionSet decodesTo Api.GitHub.Interface.Actor -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.CrossReferencedEvent
actor object_ =
    Object.selectionForCompositeField "actor" [] object_ (identity >> Decode.nullable)


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Api.GitHub.ScalarCodecs.DateTime Api.GitHub.Object.CrossReferencedEvent
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.CrossReferencedEvent
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| Reference originated in a different repository.
-}
isCrossRepository : SelectionSet Bool Api.GitHub.Object.CrossReferencedEvent
isCrossRepository =
    Object.selectionForField "Bool" "isCrossRepository" [] Decode.bool


{-| Identifies when the reference was made.
-}
referencedAt : SelectionSet Api.GitHub.ScalarCodecs.DateTime Api.GitHub.Object.CrossReferencedEvent
referencedAt =
    Object.selectionForField "ScalarCodecs.DateTime" "referencedAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The HTTP path for this pull request.
-}
resourcePath : SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.CrossReferencedEvent
resourcePath =
    Object.selectionForField "ScalarCodecs.Uri" "resourcePath" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| Issue or pull request that made the reference.
-}
source : SelectionSet decodesTo Api.GitHub.Union.ReferencedSubject -> SelectionSet decodesTo Api.GitHub.Object.CrossReferencedEvent
source object_ =
    Object.selectionForCompositeField "source" [] object_ identity


{-| Issue or pull request to which the reference was made.
-}
target : SelectionSet decodesTo Api.GitHub.Union.ReferencedSubject -> SelectionSet decodesTo Api.GitHub.Object.CrossReferencedEvent
target object_ =
    Object.selectionForCompositeField "target" [] object_ identity


{-| The HTTP URL for this pull request.
-}
url : SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.CrossReferencedEvent
url =
    Object.selectionForField "ScalarCodecs.Uri" "url" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| Checks if the target will be closed when the source is merged.
-}
willCloseTarget : SelectionSet Bool Api.GitHub.Object.CrossReferencedEvent
willCloseTarget =
    Object.selectionForField "Bool" "willCloseTarget" [] Decode.bool