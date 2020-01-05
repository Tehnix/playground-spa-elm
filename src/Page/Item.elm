module Page.Item exposing (Model, Msg, init, update, view)

import Application.Types exposing (GlobalModel, GlobalMsg, ItemParameters)
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Button exposing (buttonConfig)
import Material.Card
    exposing
        ( card
        , cardActionButton
        , cardActionIcon
        , cardActions
        , cardBlock
        , cardConfig
        )
import Material.IconButton exposing (iconButtonConfig)
import Material.Typography as Typography
import Page.Types exposing (Page)


type alias Model =
    { counter : Int
    , color : Color
    , params : Maybe ItemParameters
    }


type Msg
    = Increment
    | Decrement
    | ToggleColor


type Color
    = Green
    | Red


init : Maybe ItemParameters -> Model
init params =
    { params = params, counter = 0, color = Green }


view : Page Model Msg
view t _ model =
    let
        color =
            case model.color of
                Green ->
                    style "color" "green"

                Red ->
                    style "color" "red"

        cardPadding =
            style "padding" "8px"

        cardMargin =
            style "margin" "10px"

        cardTitle =
            case model.params of
                Just p ->
                    [ h1 [ cardMargin, Typography.headline5 ] [ text (Maybe.withDefault "From ?" p.from) ] ]

                Nothing ->
                    []

        content =
            card { cardConfig | additionalAttributes = [ cardPadding, cardMargin ] }
                { blocks =
                    [ cardBlock <|
                        div []
                            cardTitle
                    , cardBlock <|
                        div []
                            [ div [ Typography.body1, cardPadding, cardMargin ] [ text (String.fromInt model.counter) ]
                            ]
                    ]
                , actions =
                    Just <|
                        cardActions
                            { buttons =
                                [ cardActionButton { buttonConfig | onClick = Just Increment }
                                    (t { k = "sharedIncrement", default = "Increment" })
                                , cardActionButton { buttonConfig | onClick = Just Decrement }
                                    (t { k = "sharedDecrement", default = "Decrement" })
                                ]
                            , icons =
                                [ cardActionIcon { iconButtonConfig | onClick = Just ToggleColor, additionalAttributes = [ color ] }
                                    "swap_horiz"
                                ]
                            }
                }
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
