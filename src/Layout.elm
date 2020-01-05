module Layout exposing (globalStyles, menu, theme)

import Application.I18n.Types exposing (I18n)
import Application.Route as Route
import Css as Css exposing (..)
import Css.Global exposing (global)
import Global as Global
import Helper.Route exposing (toUrl)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)


theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }


globalStyles : Html msg
globalStyles =
    Css.Global.global
        [ Css.Global.html
            [ backgroundColor (rgb 248 253 252)
            , Css.height (pct 100)
            , Css.width (pct 100)
            ]
        , Css.Global.body
            [ displayFlex
            , Css.height (pct 100)
            , Css.width (pct 100)
            , flexDirection column
            ]
        ]


menu : I18n -> Html Global.Msg
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
    in
    div [ css [ padded, borderBottom3 (px 1) solid (hex "c0c0c0") ] ] <|
        List.map menuLink links
            ++ [ a [ css [ inline, padded ], href "/not-found" ] [ text "Not found" ] ]
            ++ [ button [ onClick (Global.ChangeLanguage "en") ] [ text "en" ] ]
