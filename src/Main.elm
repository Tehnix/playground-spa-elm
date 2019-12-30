module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Core.Config as Config exposing (Config)
import Core.I18n as I18n
import Core.Route as Route exposing (Route)
import Global as Global
import Helper.Maybe exposing (maybe)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Layout as Layout
import Page.Error as Error
import Page.Home as Home
import Page.Item as Item
import Page.NotFound as NotFound
import Url exposing (Url)
import Url.Parser as UrlParser


{-| The `Model` is the state of our application. This is what is
passed through the `view` functions, to generate the final document
that the user is presented with.
-}
type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , config : Config
    , t : I18n.TranslationKey -> String
    , global : Global.Model
    , pageModel : PageModel
    }


{-| The `PageModel` is a union type of all pages. This allows us to
pattern match directly in our `view` function, to decide which page
we should display. Alternatively we would have to dig into the route.

When adding a new page, you will want to update this with the page
model.

-}
type PageModel
    = NotFound
    | Home Home.Model
    | Item Item.Model


{-| The `Msg` type is what defines the possible actions in our application,
and is what `update` acts on.

When adding a new page, you will want to update this with the page msg.

-}
type
    Msg
    -- Events that are handled behind the scenes.
    = UrlChanged Url
    | LinkClicked UrlRequest
      -- Global events.
    | GlobalMsg Global.Msg
      -- Our page events.
    | HomeMsg Home.Msg
    | ItemMsg Item.Msg


{-| This is our entry point for the whole application. It stitches together all
of our functions that control the application:

  - `init` sets up the initial state
  - `update` handles all events in our application
  - `subscriptions` handles all asynchronous events in our application
  - `onUrlRequest` is where all links go through (e.g. clicking on an `a`),
    with the result going to `update`
  - `onUrlChange` handles URL changes, with the result going to `update`

-}
main : Program Encode.Value Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


{-| When the application is started up, the initial URL is passed to `init`. We
then decide where to route the user, along with setting up other things for our
initial model.
-}
init : Encode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        config =
            case Decode.decodeValue Config.decoder flags of
                Ok c ->
                    c

                Err err ->
                    Config.failedConfig (Decode.errorToString err)

        route =
            UrlParser.parse Route.parser url

        initialModel =
            { navKey = navKey
            , route = route
            , config = config
            , t = I18n.t config.i18n.translations
            , global = Global.init
            , pageModel = routeToPage Nothing Nothing route
            }
    in
    ( initialModel, Cmd.none )


{-| Figure out what page model we need to use, depending on the `Route`
that we are on. If the route is going to the same page, we make sure to
keep the page model we already have, instead of reinitialising it.

When adding a new page, you will want to update this with the new route
to the page.

-}
routeToPage : Maybe Model -> Maybe Route -> Maybe Route -> PageModel
routeToPage maybeModel previousRoute nextRoute =
    case ( previousRoute, nextRoute ) of
        ( _, Nothing ) ->
            NotFound

        ( Just Route.Home, Just Route.Home ) ->
            maybe (Home Home.init) .pageModel maybeModel

        ( _, Just Route.Home ) ->
            Home Home.init

        ( Just (Route.Item _), Just (Route.Item params) ) ->
            maybe (Item (Item.init params)) .pageModel maybeModel

        ( _, Just (Route.Item params) ) ->
            Item (Item.init params)


{-| The `view` function generates the entirety of our application from the
`Model` that is passed to it.

The top function here also controls the title of the page, and then delegates
the specific view depending on the current route in the model.

When adding a new page, you will want to update this with the new page
view.

-}
view : Model -> Document Msg
view model =
    let
        -- Helper function for converting the page specific view,
        -- into our application document.
        viewWith pageView toMsg subModel =
            let
                { html, title } =
                    pageView model.t model.global subModel
            in
            mkDocument title (Html.map toMsg html)

        -- Select the correct view, based on what model is active.
        viewDocument =
            case model.pageModel of
                NotFound ->
                    let
                        { html, title } =
                            NotFound.view model.t model.global
                    in
                    mkDocument title html

                Home subModel ->
                    viewWith Home.view HomeMsg subModel

                Item subModel ->
                    viewWith Item.view ItemMsg subModel
    in
    -- Handle the configuration failing to load.
    case model.config.loadState of
        Config.FailedToDecode err ->
            let
                { html, title } =
                    Error.view model.t model.global err
            in
            mkDocument title html

        Config.ConfigLoaded ->
            viewDocument


{-| Construc the HTML document for the Elm application.
-}
mkDocument : String -> Html msg -> Document msg
mkDocument title contents =
    { title = title
    , body = Layout.body contents
    }


{-| All externally updated events go through the subscription handler, meaning
each of the events will be handled in a case here. This can be things like a
timer that ticks every second, or similar.
-}
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


{-| All our events go through here, both user initiated and events such as URL
changes or link clicking.

In the `update` function we have the oppurtunity to update the model and/or
trigger a subsequent command, as reflected in the return type of our
function, `( Model, Cmd Msg )`.

When adding a new page, you will want to update this with the update handler
for the new page.

-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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
            ( { model | route = route, pageModel = routeToPage (Just model) model.route route }, Cmd.none )

        -- The `LinkClicked` event happens _before_ the URL is changed.
        ( LinkClicked urlRequest, _ ) ->
            handleUrlRequest urlRequest

        --------------- Handle all global events. ---------------
        ( GlobalMsg subMsg, _ ) ->
            let
                ( globalModel, globalMsg ) =
                    Global.update subMsg model.global
            in
            ( { model | global = globalModel }, Cmd.map GlobalMsg globalMsg )

        --------------- Handle events for each page. ---------------
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


{-| Helper function for restructuring a sub-model, sub-msg and global msg into
the application `Model` and `Msg` types. We batch the sub and global messages
together.

The only way to perform updates on the global model is via a global msg, since
we only update the individual page model here.

-}
updateWith : Model -> (subModel -> PageModel) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg, Cmd Global.Msg ) -> ( Model, Cmd Msg )
updateWith model toPageModel toMsg ( subModel, subMsg, globalMsg ) =
    let
        -- Insert the updated sub-model into the `pageModel` field.
        newModel =
            { model | pageModel = toPageModel subModel }

        -- Combine the local and global commands. Note that with `Cmd.batch` there
        -- is no ordering guarentee for the results (they can be async after all).
        batchedMsg =
            Cmd.batch [ Cmd.map toMsg subMsg, Cmd.map GlobalMsg globalMsg ]
    in
    ( newModel, batchedMsg )
