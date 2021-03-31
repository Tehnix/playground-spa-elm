-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.OrganizationInvitation exposing (..)

import Api.GitHub.Enum.OrganizationInvitationRole
import Api.GitHub.Enum.OrganizationInvitationType
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
createdAt : SelectionSet Api.GitHub.ScalarCodecs.DateTime Api.GitHub.Object.OrganizationInvitation
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The email address of the user invited to the organization.
-}
email : SelectionSet (Maybe String) Api.GitHub.Object.OrganizationInvitation
email =
    Object.selectionForField "(Maybe String)" "email" [] (Decode.string |> Decode.nullable)


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.OrganizationInvitation
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The type of invitation that was sent (e.g. email, user).
-}
invitationType : SelectionSet Api.GitHub.Enum.OrganizationInvitationType.OrganizationInvitationType Api.GitHub.Object.OrganizationInvitation
invitationType =
    Object.selectionForField "Enum.OrganizationInvitationType.OrganizationInvitationType" "invitationType" [] Api.GitHub.Enum.OrganizationInvitationType.decoder


{-| The user who was invited to the organization.
-}
invitee : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.OrganizationInvitation
invitee object_ =
    Object.selectionForCompositeField "invitee" [] object_ (identity >> Decode.nullable)


{-| The user who created the invitation.
-}
inviter : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet decodesTo Api.GitHub.Object.OrganizationInvitation
inviter object_ =
    Object.selectionForCompositeField "inviter" [] object_ identity


{-| The organization the invite is for
-}
organization : SelectionSet decodesTo Api.GitHub.Object.Organization -> SelectionSet decodesTo Api.GitHub.Object.OrganizationInvitation
organization object_ =
    Object.selectionForCompositeField "organization" [] object_ identity


{-| The user's pending role in the organization (e.g. member, owner).
-}
role : SelectionSet Api.GitHub.Enum.OrganizationInvitationRole.OrganizationInvitationRole Api.GitHub.Object.OrganizationInvitation
role =
    Object.selectionForField "Enum.OrganizationInvitationRole.OrganizationInvitationRole" "role" [] Api.GitHub.Enum.OrganizationInvitationRole.decoder