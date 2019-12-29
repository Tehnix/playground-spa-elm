module Page.Home exposing (Model, Msg, init, update, view)

import Global as Global
import Helper.Bool exposing (bool, when)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { text : String
    , showReversed : Bool
    }


type Msg
    = ReverseText
    | ChangeInput String


init : Model
init =
    { text = "", showReversed = False }


view : Global.Model -> Model -> Html Msg
view _ model =
    div []
        [ input [ placeholder "Text to reverse", value model.text, onInput ChangeInput ] []
        , div [] [ text (when model.showReversed String.reverse model.text) ]
        , button [ onClick ReverseText ] [ text "Reverse Text" ]
        ]


update : Global.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd Global.Msg )
update _ msg model =
    case msg of
        ReverseText ->
            ( { model | showReversed = bool True False model.showReversed }, Cmd.none, Cmd.none )

        ChangeInput newText ->
            ( { model | text = newText }, Cmd.none, Cmd.none )
