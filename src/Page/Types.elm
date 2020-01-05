module Page.Types exposing (Page)

import Application.I18n.Types exposing (Translate)
import Application.Types exposing (GlobalModel)
import Html.Styled exposing (Html)


type alias Page model msg =
    Translate -> GlobalModel -> model -> { title : String, html : Html msg }
