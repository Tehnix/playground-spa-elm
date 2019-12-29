module Page.Item exposing (Model, Msg, init, update, view)

import Global
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Route


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


init : Maybe Route.ItemParameters -> Model
init _ =
    { counter = 0, color = Green }


view : Global.Model -> Model -> Html Msg
view _ model =
    let
        color =
            case model.color of
                Green ->
                    style "color" "green"

                Red ->
                    style "color" "red"
    in
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model.counter) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick ToggleColor, color ] [ text "Toggle Color" ]
        ]


update : Global.Model -> Msg -> Model -> ( Model, Cmd Msg, Cmd Global.Msg )
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
