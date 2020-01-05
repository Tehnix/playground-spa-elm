module Application.Core.View exposing (view)

import Application.Core.Types exposing (Application(..), Model, Msg(..), PageModel(..), PageMsg(..))
import Application.I18n.Types exposing (I18n)
import Browser exposing (Document)
import Html.Styled as Html exposing (Html, toUnstyled)
import Layout as Layout
import Page.Home as Home
import Page.Initialization.Failed as InitializationFailed
import Page.Initialization.Loading as Initializating
import Page.Item as Item
import Page.NotFound as NotFound


{-| The `view` function generates the entirety of our application from the
`Model` that is passed to it.

The top function here also controls the title of the page, and then delegates
the specific view depending on the current route in the model.

When adding a new page, you will want to update this with the new page
view.

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
            , body = [ toUnstyled Layout.globalStyles, toUnstyled html ]
            }

        Ready model ->
            viewModel model


viewModel : Model -> Document Msg
viewModel model =
    let
        -- Helper function for converting the page specific view,
        -- into our application document.
        viewWith pageView toMsg subModel =
            let
                { html, title } =
                    pageView model.t model.global subModel
            in
            mkDocument model.config.i18n title (Html.map (PageMsg << toMsg) html)
    in
    case model.pageModel of
        NotFound ->
            let
                { html, title } =
                    NotFound.view model.t model.global
            in
            mkDocument model.config.i18n title html

        Home subModel ->
            viewWith Home.view HomeMsg subModel

        Item subModel ->
            viewWith Item.view ItemMsg subModel


{-| Construct the HTML document for the Elm application.
-}
mkDocument : I18n -> String -> Html Msg -> Document Msg
mkDocument i18n title contents =
    { title = title
    , body =
        List.map toUnstyled
            [ Layout.globalStyles
            , Html.map GlobalMsg (Layout.menu i18n)
            , contents
            ]
    }
