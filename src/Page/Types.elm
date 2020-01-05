module Page.Types exposing (Page)

import Application.Types exposing (GlobalModel)
import Core.I18n.Types exposing (Translate)
import Html.Styled exposing (Html)


type alias Page model msg =
    Translate
    -> GlobalModel
    -> model
    ->
        { title : String
        , html : Html msg
        }
