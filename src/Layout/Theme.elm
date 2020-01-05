module Layout.Theme exposing (theme)

import Css exposing (..)


theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }
