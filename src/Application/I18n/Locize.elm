module Application.I18n.Locize exposing (fetchLanguage, fetchSupportedLanguages, initializeLocize)

import Application.I18n exposing (decodeSupportedLanguages)
import Application.I18n.Types exposing (I18n, Language(..), Namespace(..), Version(..))
import Application.Types exposing (GlobalMsg(..))
import Helper.Bool exposing (bool)
import Http
import I18Next exposing (translationsDecoder)
import Url.Builder as UrlBuilder


{-| The namespace URL follows the format of:

  - <https://api.locize.io/{projectId}/{version}/{language}/{namespace}>

-}
mkNamespaceUrl : I18n -> Version -> Language -> Namespace -> String
mkNamespaceUrl i18n (Version version) (Language lang) (Namespace namespace) =
    UrlBuilder.absolute
        [ i18n.i18nUrl
        , i18n.i18nProjectId
        , version
        , lang
        , bool namespace (namespace ++ ".json") i18n.appendDotJson
        ]
        []


{-| The supported languages URL follows the format of:

  - <https://api.locize.io/languages/{projectId}>

-}
mkSupportedLanguagesUrl : I18n -> String
mkSupportedLanguagesUrl i18n =
    UrlBuilder.absolute
        [ i18n.i18nUrl
        , "languages"
        , bool i18n.i18nProjectId (i18n.i18nProjectId ++ ".json") i18n.appendDotJson
        ]
        []


{-| Initilize the i18n part of the application, by getting the list of
supported languages, and fetching the translations for the current
language.
-}
initializeLocize : I18n -> List (Cmd GlobalMsg)
initializeLocize i18n =
    [ fetchLanguage i18n i18n.selectedLanguage
    , fetchSupportedLanguages i18n
    ]


fetchLanguage : I18n -> Language -> Cmd GlobalMsg
fetchLanguage i18n lang =
    Http.get
        { url = mkNamespaceUrl i18n defaultVersion lang defaultNamespace
        , expect = Http.expectJson (FetchedLanguage lang) translationsDecoder
        }


fetchSupportedLanguages : I18n -> Cmd GlobalMsg
fetchSupportedLanguages i18n =
    Http.get
        { url = mkSupportedLanguagesUrl i18n
        , expect = Http.expectJson FetchedSupportedLanguages decodeSupportedLanguages
        }


{-| We only support one namespace, when using locize, so we hardcode it here.
-}
defaultNamespace : Namespace
defaultNamespace =
    Namespace "shared"


{-| We only support one namespace, when using locize, so we hardcode it here.
-}
defaultVersion : Version
defaultVersion =
    Version "latest"
