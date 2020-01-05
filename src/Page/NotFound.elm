module Page.NotFound exposing (view)

import Application.Types exposing (GlobalModel)
import Core.I18n.Types exposing (Translate)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


view : Translate -> GlobalModel -> { title : String, html : Html msg }
view t _ =
    let
        notFoundText =
            t { k = "titleNotFound", default = "Not found" }

        content =
            div []
                [ text notFoundText
                ]
    in
    { title = notFoundText, html = content }
