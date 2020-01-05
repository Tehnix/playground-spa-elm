module Application.Core.Helper exposing (mkDocument, updateWith, viewWith)

import Application.Core.Types exposing (Application(..), Model, Msg(..), PageModel(..), PageMsg(..))
import Application.I18n.Types exposing (I18n)
import Application.Types exposing (GlobalModel, GlobalMsg)
import Browser exposing (Document)
import Html.Styled as Html exposing (Html, toUnstyled)
import Layout.Menu as Layout
import Layout.Style
import Page.Types exposing (Page)


{-| Helper function for restructuring a sub-model, sub-msg and global msg into
the application `Model` and `Msg` types. We batch the sub and global messages
together.

The only way to perform updates on the global model is via a global msg, since
we only update the individual page model here.

-}
updateWith : Model -> (subModel -> PageModel) -> (subMsg -> PageMsg) -> ( subModel, Cmd subMsg, Cmd GlobalMsg ) -> ( Model, Cmd Msg )
updateWith model toPageModel toMsg ( subModel, subMsg, globalMsg ) =
    let
        -- Insert the updated sub-model into the `pageModel` field.
        newModel =
            { model | pageModel = toPageModel subModel }

        -- Combine the local and global commands. Note that with `Cmd.batch` there
        -- is no ordering guarentee for the results (they can be async after all).
        batchedMsg =
            Cmd.batch [ Cmd.map (PageMsg << toMsg) subMsg, Cmd.map GlobalMsg globalMsg ]
    in
    ( newModel, batchedMsg )


{-| Helper function for converting the page specific view, into our application
document.
-}
viewWith : Model -> Page subModel subMsg -> (subMsg -> PageMsg) -> subModel -> Document Msg
viewWith model pageView toMsg subModel =
    let
        { html, title } =
            pageView model.t model.global subModel
    in
    mkDocument model.config.i18n title (Html.map (PageMsg << toMsg) html)


{-| Construct the HTML document for the Elm application.
-}
mkDocument : I18n -> String -> Html Msg -> Document Msg
mkDocument i18n title contents =
    { title = title
    , body =
        List.map toUnstyled
            [ Layout.Style.global
            , Html.map GlobalMsg (Layout.menu i18n)
            , contents
            ]
    }
