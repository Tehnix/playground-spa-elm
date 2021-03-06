-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.RegistryPackageDependency exposing (..)

import Api.GitHub.Enum.RegistryPackageDependencyType
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


{-| Identifies the type of dependency.
-}
dependencyType : SelectionSet Api.GitHub.Enum.RegistryPackageDependencyType.RegistryPackageDependencyType Api.GitHub.Object.RegistryPackageDependency
dependencyType =
    Object.selectionForField "Enum.RegistryPackageDependencyType.RegistryPackageDependencyType" "dependencyType" [] Api.GitHub.Enum.RegistryPackageDependencyType.decoder


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.RegistryPackageDependency
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| Identifies the name of the dependency.
-}
name : SelectionSet String Api.GitHub.Object.RegistryPackageDependency
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| Identifies the version of the dependency.
-}
version : SelectionSet String Api.GitHub.Object.RegistryPackageDependency
version =
    Object.selectionForField "String" "version" [] Decode.string
