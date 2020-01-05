module Main exposing (main)

import Application.Core.Init exposing (init)
import Application.Core.Subscriptions exposing (subscriptions)
import Application.Core.Types exposing (Application(..), Msg(..), PageModel(..), PageMsg(..))
import Application.Core.Update exposing (update)
import Application.Core.View exposing (view)
import Browser
import Json.Encode as Encode


{-| This is our entry point for the whole application. It stitches together all
of our functions that control the application:

  - `init` sets up the initial state
  - `update` handles all events in our application
  - `subscriptions` handles all asynchronous events in our application
  - `onUrlRequest` is where all links go through (e.g. clicking on an `a`),
    with the result going to `update`
  - `onUrlChange` handles URL changes, with the result going to `update`

-}
main : Program Encode.Value Application Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }
