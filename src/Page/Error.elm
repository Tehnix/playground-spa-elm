module Page.Error exposing (view)

import Core.I18n exposing (Translate)
import Global as Global
import Html exposing (..)
import Html.Attributes exposing (..)


view : Translate -> Global.Model -> String -> { title : String, html : Html msg }
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
