module Page.NotFound exposing (view)

import Core.I18n exposing (Translate)
import Global as Global
import Html exposing (..)
import Html.Attributes exposing (..)


view : Translate -> Global.Model -> { title : String, html : Html msg }
view t _ =
    let
        notFoundText =
            t { k = "title.notFound", default = "Not found" }

        content =
            div []
                [ text notFoundText
                ]
    in
    { title = notFoundText, html = content }
