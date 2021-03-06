-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry exposing (..)

import Api.GitHub.Enum.OperationType
import Api.GitHub.Enum.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility
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


{-| The action name
-}
action : SelectionSet String Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
action =
    Object.selectionForField "String" "action" [] Decode.string


{-| The user who initiated the action
-}
actor : SelectionSet decodesTo Api.GitHub.Union.AuditEntryActor -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actor object_ =
    Object.selectionForCompositeField "actor" [] object_ (identity >> Decode.nullable)


{-| The IP address of the actor
-}
actorIp : SelectionSet (Maybe String) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actorIp =
    Object.selectionForField "(Maybe String)" "actorIp" [] (Decode.string |> Decode.nullable)


{-| A readable representation of the actor's location
-}
actorLocation : SelectionSet decodesTo Api.GitHub.Object.ActorLocation -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actorLocation object_ =
    Object.selectionForCompositeField "actorLocation" [] object_ (identity >> Decode.nullable)


{-| The username of the user who initiated the action
-}
actorLogin : SelectionSet (Maybe String) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actorLogin =
    Object.selectionForField "(Maybe String)" "actorLogin" [] (Decode.string |> Decode.nullable)


{-| The HTTP path for the actor.
-}
actorResourcePath : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actorResourcePath =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "actorResourcePath" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| The HTTP URL for the actor.
-}
actorUrl : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
actorUrl =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "actorUrl" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| Can members create repositories in the organization.
-}
canCreateRepositories : SelectionSet (Maybe Bool) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
canCreateRepositories =
    Object.selectionForField "(Maybe Bool)" "canCreateRepositories" [] (Decode.bool |> Decode.nullable)


{-| The time the action was initiated
-}
createdAt : SelectionSet Api.GitHub.ScalarCodecs.PreciseDateTime Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
createdAt =
    Object.selectionForField "ScalarCodecs.PreciseDateTime" "createdAt" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecPreciseDateTime |> .decoder)


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The corresponding operation type for the action
-}
operationType : SelectionSet (Maybe Api.GitHub.Enum.OperationType.OperationType) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
operationType =
    Object.selectionForField "(Maybe Enum.OperationType.OperationType)" "operationType" [] (Api.GitHub.Enum.OperationType.decoder |> Decode.nullable)


{-| The Organization associated with the Audit Entry.
-}
organization : SelectionSet decodesTo Api.GitHub.Object.Organization -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
organization object_ =
    Object.selectionForCompositeField "organization" [] object_ (identity >> Decode.nullable)


{-| The name of the Organization.
-}
organizationName : SelectionSet (Maybe String) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
organizationName =
    Object.selectionForField "(Maybe String)" "organizationName" [] (Decode.string |> Decode.nullable)


{-| The HTTP path for the organization
-}
organizationResourcePath : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
organizationResourcePath =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "organizationResourcePath" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| The HTTP URL for the organization
-}
organizationUrl : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
organizationUrl =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "organizationUrl" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| The user affected by the action
-}
user : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
user object_ =
    Object.selectionForCompositeField "user" [] object_ (identity >> Decode.nullable)


{-| For actions involving two users, the actor is the initiator and the user is the affected user.
-}
userLogin : SelectionSet (Maybe String) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
userLogin =
    Object.selectionForField "(Maybe String)" "userLogin" [] (Decode.string |> Decode.nullable)


{-| The HTTP path for the user.
-}
userResourcePath : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
userResourcePath =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "userResourcePath" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| The HTTP URL for the user.
-}
userUrl : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
userUrl =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "userUrl" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)


{-| The permission for visibility level of repositories for this organization.
-}
visibility : SelectionSet (Maybe Api.GitHub.Enum.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility) Api.GitHub.Object.OrgUpdateMemberRepositoryCreationPermissionAuditEntry
visibility =
    Object.selectionForField "(Maybe Enum.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility)" "visibility" [] (Api.GitHub.Enum.OrgUpdateMemberRepositoryCreationPermissionAuditEntryVisibility.decoder |> Decode.nullable)
