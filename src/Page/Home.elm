module Page.Home exposing (Model, Msg, init, update, view)

import Api.Query exposing (makeRequest)
import Api.Repositories exposing (Repository)
import Application.Config exposing (Config)
import Application.Types exposing (GlobalModel, GlobalMsg)
import Graphql.Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Button exposing (buttonConfig)
import Material.Card exposing (card, cardActionButton, cardActionIcon, cardActions, cardBlock, cardConfig)
import Material.HelperText exposing (helperText, helperTextConfig)
import Material.IconButton exposing (iconButtonConfig)
import Material.TextField exposing (textField, textFieldConfig)
import Material.Typography as Typography
import Page.Types exposing (Page)
import RemoteData exposing (RemoteData)


type alias Model =
    { repoName : String
    , repoOwner : String
    , repo : RemoteData (Graphql.Http.Error Repository) Repository
    }


type Msg
    = FetchRepo
    | FetchedRepo (RemoteData (Graphql.Http.Error Repository) Repository)
    | ChangeRepoNameInput String
    | ChangeRepoOwnerInput String
    | Clear


init : Model
init =
    { repoName = "", repoOwner = "", repo = RemoteData.NotAsked }


view : Page Model Msg
view t _ model =
    let
        cardPadding =
            style "padding" "8px"

        cardMargin =
            style "margin" "10px"

        cardTitle =
            case model.repo of
                RemoteData.Success _ ->
                    model.repoName

                _ ->
                    t { k = "sharedNone", default = "None" }

        content =
            card { cardConfig | additionalAttributes = [ cardPadding, cardMargin ] }
                { blocks =
                    [ cardBlock <|
                        div []
                            [ h2 [ Typography.headline5 ] [ text cardTitle ]
                            ]
                    , cardBlock <|
                        div [ style "display" "flex" ]
                            [ div [ style "margin-right" "10px" ]
                                [ textField
                                    { textFieldConfig
                                        | label = Just <| t { k = "sharedRepoName", default = "Repo name" }
                                        , value = model.repoName
                                        , onInput = Just ChangeRepoNameInput
                                    }
                                , helperText { helperTextConfig | persistent = True } (t { k = "sharedRepositoryName", default = "Repository name" })
                                ]
                            , div []
                                [ textField
                                    { textFieldConfig
                                        | label = Just <| t { k = "sharedRepoOwner", default = "Repo owner" }
                                        , value = model.repoOwner
                                        , onInput = Just ChangeRepoOwnerInput
                                    }
                                , helperText { helperTextConfig | persistent = True } (t { k = "sharedRepositoryOwner", default = "Repository owner" })
                                ]
                            ]
                    ]
                , actions =
                    Just <|
                        cardActions
                            { buttons =
                                [ cardActionButton { buttonConfig | onClick = Just FetchRepo }
                                    (t { k = "sharedLoadRepo", default = "Load Repo" })
                                ]
                            , icons =
                                [ cardActionIcon { iconButtonConfig | onClick = Just Clear }
                                    "delete"
                                ]
                            }
                }
    in
    { title = t { k = "titleItem", default = "Item" }, html = content }


update : Config -> GlobalModel -> Msg -> Model -> ( Model, Cmd Msg, Cmd GlobalMsg )
update config _ msg model =
    case msg of
        FetchRepo ->
            let
                request =
                    makeRequest config (Api.Repositories.query { name = model.repoName, owner = model.repoOwner }) FetchedRepo
            in
            ( model, request, Cmd.none )

        FetchedRepo response ->
            ( { model | repo = response }, Cmd.none, Cmd.none )

        ChangeRepoNameInput newText ->
            ( { model | repoName = newText }, Cmd.none, Cmd.none )

        ChangeRepoOwnerInput newText ->
            ( { model | repoOwner = newText }, Cmd.none, Cmd.none )

        Clear ->
            ( { model | repoName = "", repoOwner = "", repo = RemoteData.NotAsked }, Cmd.none, Cmd.none )
