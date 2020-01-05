module Page.NotFound exposing (view)

import Application.Types exposing (GlobalModel)
import Core.I18n.Types exposing (Translate)
import Css as Css exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Styled as Styled
import Html.Styled.Attributes as Attributes exposing (css)
import Material.Typography as Typography


view : Translate -> GlobalModel -> { title : String, html : Html msg }
view t _ =
    let
        notFoundText =
            t { k = "titleNotFound", default = "Not found" }

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
                        [ Styled.h1 [] [ Styled.text notFoundText ] ]
                    ]
    in
    { title = notFoundText, html = content }
