module Layout.Page exposing (body, menu)

import Application.Types as Route exposing (GlobalMsg(..))
import Core.I18n.Types exposing (I18n, Language(..), Translate)
import Core.Types exposing (Msg(..))
import Dict as Dict
import Helper.Route exposing (toUrl)
import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Layout.Theme
import Layout.Types exposing (Layout)
import Material.Button exposing (buttonConfig, raisedButton)
import Material.Typography as Typography


body : Layout
body t i18n contents =
    [ Layout.Theme.globalStyle
    , Html.map GlobalMsg (menu t i18n)
    , contents
    ]


menu : Translate -> I18n -> Html GlobalMsg
menu t i18n =
    let
        inline =
            style "display" "inline-block"

        padded =
            style "padding" "10px"

        links =
            [ { route = Route.Home, display = "Home" }
            , { route = Route.Item (Just { from = Just "tests", to = Nothing }), display = "Item tests" }
            , { route = Route.Item Nothing, display = "Item" }
            ]

        menuLink link =
            a [ inline, padded, Typography.body1, href (toUrl link.route) ] [ text link.display ]

        langBtn ( lang, _ ) =
            raisedButton { buttonConfig | onClick = Just (ChangeLanguage (Language lang)) } lang
    in
    div [ padded, style "border-bottom" "1px solid #c0c0c0" ] <|
        List.map menuLink links
            ++ a [ inline, padded, Typography.body1, href "/not-found" ] [ text (t { k = "titleNotFound", default = "Not found" }) ]
            :: List.map langBtn (Dict.toList i18n.supportedLanguages)
