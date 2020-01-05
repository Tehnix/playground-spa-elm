module Application.I18n.Locize exposing (..)

import Application.I18n.Types exposing (Language)


{-| We only support one namespace, when using locize, so we hardcode it here.
-}
hardcodedNamespace : String
hardcodedNamespace =
    "shared"
