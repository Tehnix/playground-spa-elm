module Page.Initialization.Failed exposing (view)

import Css as Css exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Styled as Styled
import Html.Styled.Attributes as Attributes exposing (css)
import Material.Typography as Typography


view : String -> { title : String, html : Html msg }
view error =
    let
        headline =
            "Failed to initialize"

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
                            , flexDirection column
                            ]
                        ]
                        [ Styled.h1 [] [ Styled.text headline ]
                        , Styled.p [ Attributes.fromUnstyled Typography.body1 ] [ Styled.text error ]
                        ]
                    ]
    in
    { title = headline, html = content }
