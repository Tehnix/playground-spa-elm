module Application.Core.Types exposing (Application(..), Model, Msg(..), PageModel(..), PageMsg(..))

import Application.Config exposing (Config)
import Application.I18n as I18n
import Application.I18n.Types as I18n
import Application.Route exposing (Route)
import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Global as Global
import Page.Home as Home
import Page.Item as Item
import Url exposing (Url)


{-| The `Application` is where we track our application state, at
a higher level, such as initialization and when the application is
ready.
-}
type Application
    = Initializing
    | FailedToInitialize String
    | Ready Model


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
    | PageMsg PageMsg


type PageMsg
    = HomeMsg Home.Msg
    | ItemMsg Item.Msg
