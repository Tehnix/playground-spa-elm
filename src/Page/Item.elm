module Page.Item exposing (Model, Msg, init, update)

import Global
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { counter : Int
    , color : Color
    }


type Msg
    = Increment
    | Decrement
    | ToggleColor


type Color
    = Green
    | Red


init : Model
init =
    { counter = 0, color = Green }


update : Global.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd Global.Msg )
update global msg model =
    case msg of
        ToggleColor ->
            case model.color of
                Green ->
                    ( { model | color = Red }, Cmd.none, Cmd.none )

                Red ->
                    ( { model | color = Green }, Cmd.none, Cmd.none )

        Increment ->
            ( { model | counter = model.counter + 1 }, Cmd.none, Cmd.none )

        Decrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none, Cmd.none )
