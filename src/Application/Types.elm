module Application.Types exposing (GlobalModel, GlobalMsg(..), User(..))

import Application.I18n.Types exposing (Language(..), SupportedLanguage)
import Dict exposing (Dict)
import Http
import I18Next exposing (Translations)


{-| The `Model` keeps track of shared state in our application.
-}
type alias GlobalModel =
    { user : User
    , language : String
    }


{-| The `Msg` type is what defines the possible actions in our application,
at a global level, such as authentication and logout.
-}
type GlobalMsg
    = Authentication User
    | ChangeLanguage Language
    | FetchedSupportedLanguages (Result Http.Error (Dict String SupportedLanguage))
    | FetchedLanguage Language (Result Http.Error Translations)


type alias UserInfo =
    { username : String
    , email : String
    }


type User
    = Authenticated UserInfo
    | Unauthenticated
