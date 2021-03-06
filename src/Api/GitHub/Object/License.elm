-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Object.License exposing (..)

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


{-| The full text of the license
-}
body : SelectionSet String Api.GitHub.Object.License
body =
    Object.selectionForField "String" "body" [] Decode.string


{-| The conditions set by the license
-}
conditions : SelectionSet decodesTo Api.GitHub.Object.LicenseRule -> SelectionSet (List (Maybe decodesTo)) Api.GitHub.Object.License
conditions object_ =
    Object.selectionForCompositeField "conditions" [] object_ (identity >> Decode.nullable >> Decode.list)


{-| A human-readable description of the license
-}
description : SelectionSet (Maybe String) Api.GitHub.Object.License
description =
    Object.selectionForField "(Maybe String)" "description" [] (Decode.string |> Decode.nullable)


{-| Whether the license should be featured
-}
featured : SelectionSet Bool Api.GitHub.Object.License
featured =
    Object.selectionForField "Bool" "featured" [] Decode.bool


{-| Whether the license should be displayed in license pickers
-}
hidden : SelectionSet Bool Api.GitHub.Object.License
hidden =
    Object.selectionForField "Bool" "hidden" [] Decode.bool


id : SelectionSet Api.GitHub.ScalarCodecs.Id Api.GitHub.Object.License
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| Instructions on how to implement the license
-}
implementation : SelectionSet (Maybe String) Api.GitHub.Object.License
implementation =
    Object.selectionForField "(Maybe String)" "implementation" [] (Decode.string |> Decode.nullable)


{-| The lowercased SPDX ID of the license
-}
key : SelectionSet String Api.GitHub.Object.License
key =
    Object.selectionForField "String" "key" [] Decode.string


{-| The limitations set by the license
-}
limitations : SelectionSet decodesTo Api.GitHub.Object.LicenseRule -> SelectionSet (List (Maybe decodesTo)) Api.GitHub.Object.License
limitations object_ =
    Object.selectionForCompositeField "limitations" [] object_ (identity >> Decode.nullable >> Decode.list)


{-| The license full name specified by <https://spdx.org/licenses>
-}
name : SelectionSet String Api.GitHub.Object.License
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| Customary short name if applicable (e.g, GPLv3)
-}
nickname : SelectionSet (Maybe String) Api.GitHub.Object.License
nickname =
    Object.selectionForField "(Maybe String)" "nickname" [] (Decode.string |> Decode.nullable)


{-| The permissions set by the license
-}
permissions : SelectionSet decodesTo Api.GitHub.Object.LicenseRule -> SelectionSet (List (Maybe decodesTo)) Api.GitHub.Object.License
permissions object_ =
    Object.selectionForCompositeField "permissions" [] object_ (identity >> Decode.nullable >> Decode.list)


{-| Whether the license is a pseudo-license placeholder (e.g., other, no-license)
-}
pseudoLicense : SelectionSet Bool Api.GitHub.Object.License
pseudoLicense =
    Object.selectionForField "Bool" "pseudoLicense" [] Decode.bool


{-| Short identifier specified by <https://spdx.org/licenses>
-}
spdxId : SelectionSet (Maybe String) Api.GitHub.Object.License
spdxId =
    Object.selectionForField "(Maybe String)" "spdxId" [] (Decode.string |> Decode.nullable)


{-| URL to the license on <https://choosealicense.com>
-}
url : SelectionSet (Maybe Api.GitHub.ScalarCodecs.Uri) Api.GitHub.Object.License
url =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "url" [] (Api.GitHub.ScalarCodecs.codecs |> Api.GitHub.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)
