module Core.Types exposing (Application(..), Model, Msg(..))

import Application.Config exposing (Config)
import Application.Page.Types exposing (PageModel, PageMsg)
import Application.Types exposing (GlobalModel, GlobalMsg, Route)
import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Core.I18n as I18n
import Core.I18n.Types as I18n
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
    , global : GlobalModel
    , pageModel : PageModel
    }


{-| The `Msg` type is what defines the possible actions in our application,
and is what `update` acts on.
-}
type
    Msg
    -- Events that are handled behind the scenes.
    = UrlChanged Url
    | LinkClicked UrlRequest
      -- Global events.
    | GlobalMsg GlobalMsg
      -- Our page events.
    | PageMsg PageMsg
