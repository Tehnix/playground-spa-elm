module Core.I18n exposing (I18n, Translate, TranslationKey, decoder, t)

import I18Next exposing (Translations, initialTranslations, translationsDecoder)
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)


type alias I18n =
    { translations : Translations
    , supportedLanguages : List String
    , selectedLanguage : String
    }


type alias Translate =
    TranslationKey -> String


type alias TranslationKey =
    { k : String
    , default : String
    }


{-| Attempt to translate a given key, falling back to the supplied default value.

This function wraps the `t` function from I18Next, to be able to fallback to a
default value, and provide a nicer API by using records, avoiding mistakenly
switching the key and default value around.

E.g.

    import I18Next
    import Json.Decode as Decode
    fakeTranslations : I18Next.Translations
    fakeTranslations =
        case Decode.decodeString I18Next.translationsDecoder "{ \"greet\": \"Hello\" }" of
            Ok t -> t
            Err _ -> I18Next.initialTranslations

    t fakeTranslations { k = "greet", default = "Goodbye" }
    --> "Hello"

    t fakeTranslations { k = "wrongGreet", default = "Goodbye" }
    --> "Goodbye"

-}
t : Translations -> Translate
t translations target =
    if I18Next.hasKey translations target.k then
        I18Next.t translations target.k

    else
        target.default


{-| Decode the `I18n` JSON object.
-}
decoder : Decoder I18n
decoder =
    Decode.succeed I18n
        |> required "translations" decodeTranslation
        |> required "supportedLanguages" (list string)
        |> required "selectedLanguage" string


{-| We try to decode the translations, but make sure to fall back to the
initialTranslations from i18next.
-}
decodeTranslation : Decoder Translations
decodeTranslation =
    Decode.oneOf
        [ translationsDecoder
        , Decode.succeed initialTranslations
        ]
