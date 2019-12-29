module Page.Home exposing (Model, Msg, init, update)

import Global as Global
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { text : String
    , color : Color
    }


type Msg
    = ReverseText
    | ToggleColor


type Color
    = Green
    | Red


init : Model
init =
    { text = "", color = Green }


update : Global.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd Global.Msg )
update global msg model =
    case msg of
        ToggleColor ->
            case model.color of
                Green ->
                    ( { model | color = Red }, Cmd.none, Cmd.none )

                Red ->
                    ( { model | color = Green }, Cmd.none, Cmd.none )

        ReverseText ->
            ( { model | text = String.reverse model.text }, Cmd.none, Cmd.none )
