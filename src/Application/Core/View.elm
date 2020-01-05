module Application.Core.View exposing (view)

import Application.Core.Types exposing (Application(..), Msg(..), PageModel(..), PageMsg(..))
import Application.Page as Page
import Browser exposing (Document)
import Html.Styled exposing (toUnstyled)
import Layout.Style
import Page.Initialization.Failed as InitializationFailed
import Page.Initialization.Loading as Initializating


{-| The `view` function generates the entirety of our application from the
`Model` that is passed to it.
-}
view : Application -> Document Msg
view application =
    case application of
        Initializing ->
            let
                { html, title } =
                    Initializating.view
            in
            { title = title
            , body = [ toUnstyled html ]
            }

        FailedToInitialize err ->
            let
                { html, title } =
                    InitializationFailed.view err
            in
            { title = title
            , body = [ toUnstyled Layout.Style.global, toUnstyled html ]
            }

        Ready model ->
            Page.view model
