module Page.Error exposing (view)

import Application.Types exposing (GlobalModel)
import Core.I18n.Types exposing (Translate)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


view : Translate -> GlobalModel -> String -> { title : String, html : Html msg }
view t _ error =
    let
        errorText =
            t { k = "titleAnErrorOccurred", default = "An error occurred" }

        content =
            div []
                [ h1 [] [ text errorText ]
                , text error
                ]
    in
    { title = errorText, html = content }
