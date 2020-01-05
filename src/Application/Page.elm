module Application.Page exposing (update, view)

import Application.Page.Types exposing (PageModel(..), PageMsg(..))
import Browser exposing (Document)
import Core.Helper exposing (mkDocument, updateWith, viewWith)
import Core.Types exposing (Application(..), Model, Msg(..))
import Layout.Page
import Page.Home as Home
import Page.Item as Item
import Page.NotFound as NotFound


{-| Handle all page messages. Note We almost always discard messages, if they
are from a page that is not active.

When adding a new page, you will want to update this with the update handler
for the new page.

-}
update : Model -> PageMsg -> PageModel -> ( Model, Cmd Msg )
update model pageMsg pageModel =
    case ( pageMsg, pageModel ) of
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


{-| Handle all page views.

When adding a new page, you will want to update this with the view handler
for the new page.

-}
view : Model -> Document Msg
view model =
    case model.pageModel of
        NotFound ->
            let
                { html, title } =
                    NotFound.view model.t model.global
            in
            mkDocument Layout.Page.body model title html

        Home subModel ->
            viewWith Layout.Page.body model Home.view HomeMsg subModel

        Item subModel ->
            viewWith Layout.Page.body model Item.view ItemMsg subModel
