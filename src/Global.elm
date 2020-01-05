module Global exposing (Model, Msg(..), User(..), init, update)

{-| In this module, we keep our global state and messages, which pages
might need to access (via the model) or trigger events (via the msg),
such as user information or logout events.
-}

import Application.I18n.Types exposing (I18n, Language)


{-| The `Model` keeps track of shared state in our application.
-}
type alias Model =
    { user : User
    , language : String
    }


{-| The `Msg` type is what defines the possible actions in our application,
at a global level, such as authentication and logout.
-}
type Msg
    = Authentication User
    | ChangeLanguage Language


type alias UserInfo =
    { username : String
    , email : String
    }


type User
    = Authenticated UserInfo
    | Unauthenticated


init : Model
init =
    { user = Unauthenticated, language = "en" }


update : Msg -> Model -> I18n -> ( Model, I18n, Cmd Msg )
update msg model i18n =
    case msg of
        Authentication user ->
            ( { model | user = user }, i18n, Cmd.none )

        ChangeLanguage l ->
            Debug.todo ("Load the translations for language:" ++ l)
