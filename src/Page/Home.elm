module Page.Home exposing (Model, Msg, init, update, view)

import Application.Types exposing (GlobalModel, GlobalMsg)
import Helper.Bool exposing (bool, when)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick, onInput)
import Page.Types exposing (Page)


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


view : Page Model Msg
view t _ model =
    let
        content =
            div []
                [ input [ placeholder (t { k = "shared.textToReverse", default = "Text to reverse" }), value model.text, onInput ChangeInput ] []
                , div [] [ text (when model.showReversed String.reverse model.text) ]
                , button [ onClick ReverseText ] [ text (t { k = "shared.reverseText", default = "Reverse Text" }) ]
                ]
    in
    { title = t { k = "title.item", default = "Item" }, html = content }


update : GlobalModel -> Msg -> Model -> ( Model, Cmd Msg, Cmd GlobalMsg )
update _ msg model =
    case msg of
        ReverseText ->
            ( { model | showReversed = bool True False model.showReversed }, Cmd.none, Cmd.none )

        ChangeInput newText ->
            ( { model | text = newText }, Cmd.none, Cmd.none )
