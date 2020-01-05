module Application.I18n.Types exposing (I18n, Language(..), Namespace(..), SupportedLanguage, Translate, TranslationKey, Version(..))

import Dict exposing (Dict)
import I18Next exposing (Translations)


type alias I18n =
    { translations : Dict String Translations
    , supportedLanguages : Dict String SupportedLanguage
    , selectedLanguage : Language
    , i18nUrl : String
    , i18nProjectId : String
    , appendDotJson : Bool
    }


type alias SupportedLanguage =
    { name : String
    , nativeName : String
    , isReferenceLanguage : Bool
    }


type Language
    = Language String


type Version
    = Version String


type Namespace
    = Namespace String


type alias Translate =
    TranslationKey -> String


type alias TranslationKey =
    { k : String
    , default : String
    }
