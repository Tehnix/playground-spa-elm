module Page.Initialization.Failed exposing (view)

import Html.Styled.Attributes exposing (..)
import Html.Styled exposing (..)


view : String -> { title : String, html : Html msg }
view error =
    let
        errorText =
            "Failed to initialize"

        content =
            div []
                [ h1 [] [ text errorText ]
                , text error
                ]
    in
    { title = errorText, html = content }
