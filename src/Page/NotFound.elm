module Page.NotFound exposing (view)

import Application.I18n.Types exposing (Translate)
import Global as Global
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


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
