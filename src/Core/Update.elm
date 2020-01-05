module Core.Update exposing (update)

import Application.Global as Global
import Application.Page as Page
import Application.Page.Types exposing (PageModel(..), PageMsg(..))
import Application.Route as Route exposing (toPageModel)
import Application.Types as Route
import Browser
import Browser.Navigation as Nav
import Core.I18n as I18n
import Core.I18n.Types as I18n
import Core.Types exposing (Application(..), Model, Msg(..))
import Url
import Url.Parser as UrlParser


{-| All our events go through here, both user initiated and events such as URL
changes or link clicking.

In the `update` function we have the oppurtunity to update the model and/or
trigger a subsequent command, as reflected in the return type of our
function, `( Model, Cmd Msg )`.

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
                , t = I18n.t newConfig.i18n.selectedLanguage newConfig.i18n.translations
              }
            , Cmd.map GlobalMsg globalMsg
            )

        --------------- Handle events for each page. ---------------
        ( PageMsg pMsg, _ ) ->
            Page.update model pMsg model.pageModel
