module Page.Layout exposing (menu)

import Html exposing (..)
import Html.Attributes exposing (..)


menu : Html msg
menu =
    let
        inline =
            style "display" "inline-block"

        padded =
            style "padding" "10px"
    in
    div [ style "padding" "10px", style "border-bottom" "1px solid #c0c0c0" ]
        [ a [ inline, padded, href "/" ] [ text "Home" ]
        , a [ inline, padded, href "/item?from=tests" ] [ text "Item tests" ]
        , a [ inline, padded, href "/item" ] [ text "Item" ]
        ]
