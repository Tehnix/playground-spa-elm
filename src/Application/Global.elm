module Application.Global exposing (init, update)

{-| In this module, we keep our global state and messages, which pages
might need to access (via the model) or trigger events (via the msg),
such as user information or logout events.
-}

import Application.Types exposing (GlobalModel, GlobalMsg(..), User(..))
import Core.I18n.Locize as I18n
import Core.I18n.Types exposing (I18n, Language(..))
import Dict


init : GlobalModel
init =
    { user = Unauthenticated, language = "en" }


update : GlobalMsg -> GlobalModel -> I18n -> ( GlobalModel, I18n, Cmd GlobalMsg )
update msg model i18n =
    case msg of
        Authentication user ->
            ( { model | user = user }, i18n, Cmd.none )

        ChangeLanguage (Language l) ->
            -- Avoid refetching the language, if it already exists.
            if Dict.member l i18n.translations then
                ( model, { i18n | selectedLanguage = Language l }, Cmd.none )

            else
                ( model, { i18n | selectedLanguage = Language l }, I18n.fetchLanguage i18n (Language l) )

        FetchedSupportedLanguages supportedLanguages ->
            case supportedLanguages of
                Ok l ->
                    ( model, { i18n | supportedLanguages = l }, Cmd.none )

                Err _ ->
                    ( model, i18n, Cmd.none )

        FetchedLanguage (Language l) translations ->
            case translations of
                Ok t ->
                    ( model, { i18n | translations = Dict.insert l t i18n.translations }, Cmd.none )

                Err _ ->
                    ( model, i18n, Cmd.none )
