module Application.I18n.Types exposing (I18n, Language, Translate, TranslationKey)

import Dict exposing (Dict)
import I18Next exposing (Translations)


type alias I18n =
    { translations : Dict Language Translations
    , supportedLanguages : List String
    , selectedLanguage : String
    , i18nUrl : String
    , i18nProjectId : String
    }


type alias Language =
    String


type alias Translate =
    TranslationKey -> String


type alias TranslationKey =
    { k : String
    , default : String
    }
