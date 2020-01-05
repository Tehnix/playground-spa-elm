module Layout.Types exposing (Layout)

import Application.Types exposing (GlobalMsg(..))
import Core.I18n.Types exposing (I18n, Language(..), Translate)
import Core.Types exposing (Msg(..))
import Html exposing (Html)


type alias Layout =
    Translate -> I18n -> Html Msg -> List (Html Msg)
