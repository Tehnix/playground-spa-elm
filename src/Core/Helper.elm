module Core.Helper exposing (mkDocument, updateWith, viewWith)

import Application.Page.Types exposing (PageModel, PageMsg)
import Application.Types exposing (GlobalMsg)
import Browser exposing (Document)
import Core.Types exposing (Application(..), Model, Msg(..))
import Html.Styled as Html exposing (Html, toUnstyled)
import Layout.Types exposing (Layout)
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
viewWith : Layout -> Model -> Page subModel subMsg -> (subMsg -> PageMsg) -> subModel -> Document Msg
viewWith layout model pageView toMsg subModel =
    let
        { html, title } =
            pageView model.t model.global subModel
    in
    mkDocument layout model title (Html.map (PageMsg << toMsg) html)


{-| Construct the HTML document for the Elm application.
-}
mkDocument : Layout -> Model -> String -> Html Msg -> Document Msg
mkDocument layout model title contents =
    { title = title
    , body = List.map toUnstyled (layout model.t model.config.i18n contents)
    }
