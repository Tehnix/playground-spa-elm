module Layout.Theme exposing (globalStyle, theme)

import Css as Css exposing (..)
import Css.Global exposing (global)
import Html.Styled exposing (Html)


globalStyle : Html msg
globalStyle =
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


theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }
