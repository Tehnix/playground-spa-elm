module Core.I18n exposing (I18n, decoder)

import I18Next exposing (Translations, initialTranslations, translationsDecoder)
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)


type alias I18n =
    { translations : Translations
    , supportedLanguages : List String
    , selectedLanguage : String
    }


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
