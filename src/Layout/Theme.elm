module Layout.Theme exposing (globalStyle)

import Css as Css exposing (..)
import Css.Global exposing (global)
import Html exposing (Html)
import Html.Styled as Html


globalStyle : Html msg
globalStyle =
    Html.toUnstyled <|
        Css.Global.global
            [ Css.Global.html
                [ Css.margin (px 0)
                , Css.padding (px 0)
                , Css.height (pct 100)
                , Css.width (pct 100)
                ]
            , Css.Global.body
                [ displayFlex
                , Css.margin (px 0)
                , Css.padding (px 0)
                , Css.height (pct 100)
                , Css.width (pct 100)
                , flexDirection column
                ]
            ]
