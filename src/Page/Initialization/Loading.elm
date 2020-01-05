module Page.Initialization.Loading exposing (view)

import Css as Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


view : { title : String, html : Html msg }
view =
    let
        errorText =
            "Initializing..."

        content =
            div
                [ css
                    [ displayFlex
                    , Css.height (pct 100)
                    , Css.width (pct 100)
                    , alignItems center
                    , justifyContent center
                    ]
                ]
                [ div
                    [ css
                        [ displayFlex
                        , Css.width auto
                        , textAlign center
                        ]
                    ]
                    [ h1 [] [ text errorText ] ]
                ]
    in
    { title = errorText, html = content }
