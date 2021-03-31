-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.GitActor exposing (..)

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


type alias AvatarUrlOptionalArguments =
    { size : OptionalArgument Int }


{-| A URL pointing to the author's public avatar.

  - size - The size of the resulting square image.

-}
avatarUrl : (AvatarUrlOptionalArguments -> AvatarUrlOptionalArguments) -> SelectionSet Api.GitHub.ScalarCodecs.Uri Api.GitHub.Object.GitActor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionForField "ScalarCodecs.Uri" "avatarUrl" optionalArgs (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| The timestamp of the Git action (authoring or committing).
-}
date : SelectionSet (Maybe Api.GitHub.ScalarCodecs.GitTimestamp) Api.GitHub.Object.GitActor
date =
    Object.selectionForField "(Maybe ScalarCodecs.GitTimestamp)" "date" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecGitTimestamp |> .decoder |> Decode.nullable)


{-| The email in the Git commit.
-}
email : SelectionSet (Maybe String) Api.GitHub.Object.GitActor
email =
    Object.selectionForField "(Maybe String)" "email" [] (Decode.string |> Decode.nullable)


{-| The name in the Git commit.
-}
name : SelectionSet (Maybe String) Api.GitHub.Object.GitActor
name =
    Object.selectionForField "(Maybe String)" "name" [] (Decode.string |> Decode.nullable)


{-| The GitHub user corresponding to the email field. Null if no such user exists.
-}
user : SelectionSet decodesTo Api.GitHub.Object.User -> SelectionSet (Maybe decodesTo) Api.GitHub.Object.GitActor
user object_ =
    Object.selectionForCompositeField "user" [] object_ (identity >> Decode.nullable)