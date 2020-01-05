module Application.Types exposing (GlobalModel, GlobalMsg(..), ItemParameters, Route(..), User(..))

import Core.I18n.Types exposing (Language(..), SupportedLanguage)
import Dict exposing (Dict)
import Http
import I18Next exposing (Translations)


{-| Our `Route` data type defines all the routes of our application,
and sets up what data is relevant for each route to contain.

When adding a new route, you will want to go through the following
steps:

  - Adding handling in the `parser`
  - Instructing `toUrl` how to convert the data type to a URL string

-}
type Route
    = Home
    | Item (Maybe ItemParameters)


type alias ItemParameters =
    { from : Maybe String
    , to : Maybe String
    }


{-| Our global model keeps track of shared state in our application.
-}
type alias GlobalModel =
    { user : User
    , language : String
    }


type GlobalMsg
    = Authentication User
    | ChangeLanguage Language
    | FetchedSupportedLanguages (Result Http.Error (Dict String SupportedLanguage))
    | FetchedLanguage Language (Result Http.Error Translations)


{-| The users authentication status.
-}
type User
    = Authenticated UserInfo
    | Unauthenticated


type alias UserInfo =
    { username : String
    , email : String
    , language : Language
    }
