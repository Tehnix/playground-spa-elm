-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.EnterpriseAdministratorInvitation exposing (..)

import Api.GitHub.Enum.EnterpriseAdministratorRole
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


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Api.GitHub.ScalarCodecs.DateTime Api.GitHub.Object.EnterpriseAdministratorInvitation
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The email of the person who was invited to the enterprise.
-}
email : SelectionSet (Maybe String) Api.GitHub.Object.EnterpriseAdministratorInvitation
email =
    Object.selectionForField "(Maybe String)" "email" [] (Decode.string |> Decode.nullable)


{-| The enterprise the invitation is for.
-}
enterprise : SelectionSet decodesTo Api.GitHub.Object.Enterprise -> SelectionSet decodesTo Api.GitHub.Object.EnterpriseAdministratorInvitation
enterprise object_ =
    Object.selectionForCompositeField "enterprise" [] object_ identity


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.EnterpriseAdministratorInvitation
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The user who was invited to the enterprise.
-}
invitee : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.EnterpriseAdministratorInvitation
invitee object_ =
    Object.selectionForCompositeField "invitee" [] object_ (identity >> Decode.nullable)


{-| The user who created the invitation.
-}
inviter : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.EnterpriseAdministratorInvitation
inviter object_ =
    Object.selectionForCompositeField "inviter" [] object_ (identity >> Decode.nullable)


{-| The invitee's pending role in the enterprise (owner or billing\_manager).
-}
role : SelectionSet Api.GitHub.Enum.EnterpriseAdministratorRole.EnterpriseAdministratorRole Api.GitHub.Object.EnterpriseAdministratorInvitation
role =
    Object.selectionForField "Enum.EnterpriseAdministratorRole.EnterpriseAdministratorRole" "role" [] Api.GitHub.Enum.EnterpriseAdministratorRole.decoder
