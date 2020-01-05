module Layout.Menu exposing (menu)

import Application.I18n.Types exposing (I18n, Language(..))
import Application.Route as Route
import Application.Types exposing (GlobalMsg(..))
import Css exposing (..)
import Dict as Dict
import Helper.Route exposing (toUrl)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)


menu : I18n -> Html GlobalMsg
menu i18n =
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
            a [ css [ inline, padded ], href (toUrl link.route) ] [ text link.display ]

        langBtn ( lang, meta ) =
            button [ onClick (ChangeLanguage (Language lang)) ] [ text lang ]
    in
    div [ css [ padded, borderBottom3 (px 1) solid (hex "c0c0c0") ] ] <|
        List.map menuLink links
            ++ [ a [ css [ inline, padded ], href "/not-found" ] [ text "Not found" ]
               ]
            ++ List.map langBtn (Dict.toList i18n.supportedLanguages)
