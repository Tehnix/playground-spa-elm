module Page.Initialization.Loading exposing (view)

import Css as Css exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Styled as Styled
import Html.Styled.Attributes as Attributes exposing (css)
import Material.Typography as Typography


view : { title : String, html : Html msg }
view =
    let
        headline =
            "Initializing..."

        content =
            Styled.toUnstyled <|
                Styled.div
                    [ css
                        [ displayFlex
                        , Css.height (pct 100)
                        , Css.width (pct 100)
                        , alignItems center
                        , justifyContent center
                        ]
                    , Attributes.fromUnstyled Typography.headline6
                    ]
                    [ Styled.div
                        [ css
                            [ displayFlex
                            , Css.width auto
                            , textAlign center
                            ]
                        ]
                        [ Styled.h1 [] [ Styled.text headline ] ]
                    ]
    in
    { title = headline, html = content }
