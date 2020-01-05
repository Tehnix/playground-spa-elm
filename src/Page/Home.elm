module Page.Home exposing (Model, Msg, init, update, view)

import Application.Types exposing (GlobalModel, GlobalMsg)
import Helper.Bool exposing (bool, when)
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
import Material.HelperText exposing (helperText, helperTextConfig)
import Material.IconButton exposing (iconButtonConfig)
import Material.TextField
    exposing
        ( textField
        , textFieldConfig
        )
import Material.Typography as Typography
import Page.Types exposing (Page)


type alias Model =
    { text : String
    , showReversed : Bool
    }


type Msg
    = ReverseText
    | ChangeInput String
    | ClearText


init : Model
init =
    { text = "", showReversed = False }


view : Page Model Msg
view t _ model =
    let
        cardPadding =
            style "padding" "8px"

        cardMargin =
            style "margin" "10px"

        content =
            card { cardConfig | additionalAttributes = [ cardPadding, cardMargin ] }
                { blocks =
                    [ cardBlock <|
                        div []
                            [ h2 [ Typography.headline5 ] [ text "Title" ]
                            ]
                    , cardBlock <|
                        div []
                            [ textField
                                { textFieldConfig
                                    | label = Just <| t { k = "sharedTextToReverse", default = "Text to reverse" }
                                    , value = model.text
                                    , onInput = Just ChangeInput
                                }
                            , helperText { helperTextConfig | persistent = True } (when model.showReversed String.reverse model.text)
                            ]
                    ]
                , actions =
                    Just <|
                        cardActions
                            { buttons =
                                [ cardActionButton { buttonConfig | onClick = Just ReverseText }
                                    (t { k = "sharedReverseText", default = "Reverse Text" })
                                ]
                            , icons =
                                [ cardActionIcon { iconButtonConfig | onClick = Just ClearText }
                                    "delete"
                                ]
                            }
                }
    in
    { title = t { k = "titleItem", default = "Item" }, html = content }


update : GlobalModel -> Msg -> Model -> ( Model, Cmd Msg, Cmd GlobalMsg )
update _ msg model =
    case msg of
        ReverseText ->
            ( { model | showReversed = bool True False model.showReversed }, Cmd.none, Cmd.none )

        ChangeInput newText ->
            ( { model | text = newText }, Cmd.none, Cmd.none )

        ClearText ->
            ( { model | text = "" }, Cmd.none, Cmd.none )
