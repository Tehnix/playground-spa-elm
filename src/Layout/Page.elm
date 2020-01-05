module Layout.Page exposing (body, menu)

import Application.Types as Route exposing (GlobalMsg(..))
import Core.I18n.Types exposing (I18n, Language(..), Translate)
import Core.Types exposing (Msg(..))
import Css exposing (..)
import Dict as Dict
import Helper.Route exposing (toUrl)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
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
            display inlineBlock

        padded =
            padding (px 10)

        links =
            [ { route = Route.Home, display = "Home" }
            , { route = Route.Item (Just { from = Just "tests", to = Nothing }), display = "Item tests" }
            , { route = Route.Item Nothing, display = "Item" }
            ]

        menuLink link =
            a [ css [ inline, padded ], Attributes.fromUnstyled Typography.body1, href (toUrl link.route) ] [ text link.display ]

        langBtn ( lang, _ ) =
            Html.fromUnstyled <| raisedButton { buttonConfig | onClick = Just (ChangeLanguage (Language lang)) } lang
    in
    div [ css [ padded, borderBottom3 (px 1) solid (hex "c0c0c0") ] ] <|
        List.map menuLink links
            ++ a [ css [ inline, padded ], Attributes.fromUnstyled Typography.body1, href "/not-found" ] [ text (t { k = "titleNotFound", default = "Not found" }) ]
            :: List.map langBtn (Dict.toList i18n.supportedLanguages)
