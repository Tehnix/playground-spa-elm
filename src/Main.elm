module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Global
import Html exposing (..)
import Html.Attributes exposing (..)
import Layout as Layout
import Page.Home as Home
import Page.Item as Item
import Route as Route exposing (Route)
import Url exposing (Url)
import Url.Parser as UrlParser


{-| The `Model` is the state of our application. This is what is
passed through the `view` functions, to generate the final document
that the user is presented with.
-}
type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , global : Global.Model
    , pageModel : PageModel
    }


{-| The `PageModel` is a union type of all pages. This allows us to
pattern match directly in our `view` function, to decide which page
we should display. Alternatively we would have to dig into the route.
-}
type PageModel
    = Home Home.Model
    | Item Item.Model


{-| The `Msg` type is what defines the possible actions in our application,
and is what `update` acts on.
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

Read more about how `Browser.application` works in the documentation <https://package.elm-lang.org/packages/elm/browser/latest/Browser#application>, and potentially also `Browser.Navigation` <https://package.elm-lang.org/packages/elm/browser/1.0.0/Browser-Navigation>.

-}
main : Program () Model Msg
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
init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        route =
            UrlParser.parse Route.parser url

        initialPage =
            case route of
                Nothing ->
                    Home Home.init

                Just page ->
                    case page of
                        Route.Home ->
                            Home Home.init

                        Route.Item params ->
                            Item (Item.init params)

        initialModel =
            { navKey = navKey
            , route = route
            , global = Global.init
            , pageModel = initialPage
            }
    in
    ( initialModel, Cmd.none )


{-| The `view` function generates the entirety of our application from the
`Model` that is passed to it.

The top function here also controls the title of the page, and then delegates
the specific view depending on the current route in the model.

-}
view : Model -> Document Msg
view model =
    let
        title =
            Route.title model.route

        viewWith pageView toMsg subModel =
            pageView model.global subModel |> Html.map toMsg

        contents =
            case model.pageModel of
                Home subModel ->
                    viewWith Home.view HomeMsg subModel

                Item subModel ->
                    viewWith Item.view ItemMsg subModel
    in
    { title = title
    , body =
        [ Layout.menu
        , contents
        ]
    }


{-| All our events go through here, both user initiated and events such as URL
changes or link clicking.

In the `update` function we have the oppurtunity to update the model and/or
trigger a subsequent command, as reflected in the return type of our
function, `( Model, Cmd Msg )`.

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
            ( { model | route = route, pageModel = changePage model route }, Cmd.none )

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
        -- not active. The reason we catch it in each individual Msg pattern match,
        -- instead of a global catch-all, is to retain our exhaustiveness check, making
        -- sure we are handling all message types.
        ( ItemMsg subMsg, pageModel ) ->
            case pageModel of
                Item subModel ->
                    Item.update model.global subMsg subModel
                        |> updateWith model Item ItemMsg

                -- Do nothing if we get a message not from the current page.
                _ ->
                    ( model, Cmd.none )

        ( HomeMsg subMsg, pageModel ) ->
            case pageModel of
                Home subModel ->
                    Home.update model.global subMsg subModel
                        |> updateWith model Home HomeMsg

                -- Do nothing if we get a message not from the current page.
                _ ->
                    ( model, Cmd.none )


{-| Figure out what page model we need to use, depending on the `Route`
that we are on.
-}
changePage : Model -> Maybe Route -> PageModel
changePage model route =
    case route of
        Just Route.Home ->
            Home Home.init

        Just (Route.Item params) ->
            Item (Item.init params)

        Nothing ->
            model.pageModel


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


{-| All externally updated events go through the subscription handler, meaning
each of the events will be handled in a case here. This can be things like a
timer that ticks every second, or similar.
-}
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
