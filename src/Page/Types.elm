module Page.Types exposing (Page)

import Application.I18n.Types exposing (Translate)
import Global as Global
import Html.Styled exposing (Html)


type alias Page model msg =
    Translate -> Global.Model -> model -> { title : String, html : Html msg }
