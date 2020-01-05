module Page.Item exposing (Model, Msg, init, update, view)

import Application.Types exposing (GlobalModel, GlobalMsg, ItemParameters)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Page.Types exposing (Page)


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


init : Maybe ItemParameters -> Model
init _ =
    { counter = 0, color = Green }


view : Page Model Msg
view t _ model =
    let
        color =
            case model.color of
                Green ->
                    style "color" "green"

                Red ->
                    style "color" "red"

        content =
            div []
                [ button [ onClick Decrement ] [ text "-" ]
                , div [] [ text (String.fromInt model.counter) ]
                , button [ onClick Increment ] [ text "+" ]
                , button [ onClick ToggleColor, color ] [ text "Toggle Color" ]
                ]
    in
    { title = t { k = "titleItem", default = "Item" }, html = content }


update : GlobalModel -> Msg -> Model -> ( Model, Cmd Msg, Cmd GlobalMsg )
update _ msg model =
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
