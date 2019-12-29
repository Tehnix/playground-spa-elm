module Global exposing (Model, Msg(..), init, update)

{-| In this module, we keep our global state and messages, which pages
might need to access (via the model) or trigger events (via the msg),
such as user information or logout events.
-}


{-| The @Model@ keeps track of shared state in our application.
-}
type alias Model =
    { user : User
    }


{-| The @Msg@ type is what defines the possible actions in our application,
at a global level, such as authentication and logout.
-}
type Msg
    = Authentication User


type alias UserInfo =
    { username : String }


type User
    = Authenticated UserInfo
    | Unauthenticated


init : Model
init =
    { user = Unauthenticated }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Authentication user ->
            ( { model | user = user }, Cmd.none )
