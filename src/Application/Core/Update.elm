module Application.Core.Update exposing (update)

import Application.Core.Route as Route exposing (toPageModel)
import Application.Core.Types exposing (Application(..), Model, Msg(..), PageModel(..), PageMsg(..))
import Application.I18n as I18n
import Application.I18n.Types as I18n
import Application.Route as Route
import Browser
import Browser.Navigation as Nav
import Global as Global
import Page.Home as Home
import Page.Item as Item
import Url
import Url.Parser as UrlParser


{-| All our events go through here, both user initiated and events such as URL
changes or link clicking.

In the `update` function we have the oppurtunity to update the model and/or
trigger a subsequent command, as reflected in the return type of our
function, `( Model, Cmd Msg )`.

When adding a new page, you will want to update this with the update handler
for the new page.

-}
update : Msg -> Application -> ( Application, Cmd Msg )
update msg application =
    case application of
        Ready model ->
            let
                ( newModel, newMsg ) =
                    updateModel msg model
            in
            ( Ready newModel, newMsg )

        _ ->
            ( application, Cmd.none )


updateModel : Msg -> Model -> ( Model, Cmd Msg )
updateModel msg model =
    let
        pageMsg pMsg pageModel =
            case ( pMsg, pageModel ) of
                -- NOTE: We almost always discard messages, if they are from a page that is
                -- not active.
                ( ItemMsg subMsg, Item subModel ) ->
                    Item.update model.global subMsg subModel
                        |> updateWith model Item ItemMsg

                ( ItemMsg _, _ ) ->
                    ( model, Cmd.none )

                ( HomeMsg subMsg, Home subModel ) ->
                    Home.update model.global subMsg subModel
                        |> updateWith model Home HomeMsg

                ( HomeMsg _, _ ) ->
                    ( model, Cmd.none )

        handleUrlRequest urlRequest =
            case urlRequest of
                -- An internal URL means that we are navigating within our application
                -- and we use `pushUrl` to both update the history and trigger the url
                -- change.
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey <| Url.toString url )

                -- An external URL means we are navigating away from our site, so we
                -- simply use `load` to navigate to the requested URL, potentially
                -- leaving our site.
                Browser.External url ->
                    ( model, Nav.load url )
    in
    case ( msg, model.pageModel ) of
        -- The `UrlChanged` event happens _after_ the URL is changed, and we are now
        -- ready to act on it, updating our routes according to the `url` we have
        -- received.
        ( UrlChanged url, _ ) ->
            let
                route =
                    UrlParser.parse Route.parser url
            in
            ( { model | route = route, pageModel = toPageModel (Just model) model.route route }, Cmd.none )

        -- The `LinkClicked` event happens _before_ the URL is changed.
        ( LinkClicked urlRequest, _ ) ->
            handleUrlRequest urlRequest

        --------------- Handle all global events, including i18n. ---------------
        ( GlobalMsg subMsg, _ ) ->
            let
                ( globalModel, i18nModel, globalMsg ) =
                    Global.update subMsg model.global model.config.i18n

                oldConfig =
                    model.config

                newConfig =
                    { oldConfig | i18n = i18nModel }
            in
            ( { model
                | global = globalModel
                , config = newConfig
                , t = I18n.t model.config.i18n.selectedLanguage model.config.i18n.translations
              }
            , Cmd.map GlobalMsg globalMsg
            )

        --------------- Handle events for each page. ---------------
        ( PageMsg pMsg, _ ) ->
            pageMsg pMsg model.pageModel


{-| Helper function for restructuring a sub-model, sub-msg and global msg into
the application `Model` and `Msg` types. We batch the sub and global messages
together.

The only way to perform updates on the global model is via a global msg, since
we only update the individual page model here.

-}
updateWith : Model -> (subModel -> PageModel) -> (subMsg -> PageMsg) -> ( subModel, Cmd subMsg, Cmd Global.Msg ) -> ( Model, Cmd Msg )
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
