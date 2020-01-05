module Page.Error exposing (view)

import Application.I18n.Types exposing (Translate)
import Application.Types exposing (GlobalModel)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


view : Translate -> GlobalModel -> String -> { title : String, html : Html msg }
view t _ error =
    let
        errorText =
            t { k = "title.anErrorOccurred", default = "An error occurred" }

        content =
            div []
                [ h1 [] [ text errorText ]
                , text error
                ]
    in
    { title = errorText, html = content }
