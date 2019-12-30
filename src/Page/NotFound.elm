module Page.NotFound exposing (view)

import Global
import Html exposing (..)
import Html.Attributes exposing (..)


view : Global.Model -> { title : String, html : Html msg }
view _ =
    let
        content =
            div []
                [ text "Not found"
                ]
    in
    { title = "Not Found", html = content }
