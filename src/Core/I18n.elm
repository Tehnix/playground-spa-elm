module Core.I18n exposing (decodeSupportedLanguages, decoder, initI18n, langToString, t, t_)

import Core.I18n.Types exposing (I18n, Language(..), Namespace(..), SupportedLanguage, Translate, Version(..))
import Dict as Dict exposing (Dict)
import I18Next exposing (Translations, initialTranslations, translationsDecoder)
import Json.Decode as Decode exposing (Decoder, bool, string)
import Json.Decode.Pipeline exposing (required)


{-| Our fallback language is also our default language.
-}
fallbackLanguage : Language
fallbackLanguage =
    Language "en"


{-| Unwrap a language newtype.
-}
langToString : Language -> String
langToString (Language l) =
    l


{-| Create the initial translation entry, which will have the language
set as our fallback language.
-}
initialLanguageSingleton : Translations -> Decoder (Dict String Translations)
initialLanguageSingleton translation =
    Decode.succeed (Dict.singleton (langToString fallbackLanguage) translation)


{-| Construct an initial i18n object.
-}
initI18n : I18n
initI18n =
    { translations = Dict.singleton (langToString fallbackLanguage) initialTranslations
    , supportedLanguages = Dict.empty
    , selectedLanguage = fallbackLanguage
    , i18nUrl = ""
    , i18nProjectId = ""
    , appendDotJson = False
    }


{-| Decode the `I18n` JSON object.
-}
decoder : Decoder I18n
decoder =
    Decode.succeed I18n
        |> required "translations" (decodeTranslation |> Decode.andThen initialLanguageSingleton)
        |> required "supportedLanguages" decodeSupportedLanguages
        |> required "selectedLanguage" (Decode.map Language string)
        |> required "i18nUrl" string
        |> required "i18nProjectId" string
        |> required "appendDotJson" bool


{-| We try to decode the translations, but make sure to fall back to the
initialTranslations from i18next.
-}
decodeTranslation : Decoder Translations
decodeTranslation =
    Decode.oneOf
        [ translationsDecoder
        , Decode.succeed initialTranslations
        ]


cleanupDecoderLanguage : ( String, SupportedLanguage ) -> ( String, SupportedLanguage )
cleanupDecoderLanguage ( l, s ) =
    let
        cleaned =
            case String.split "-" l of
                firstPart :: _ ->
                    firstPart

                [] ->
                    ""
    in
    ( cleaned, s )


decodeSupportedLanguages : Decoder (Dict String SupportedLanguage)
decodeSupportedLanguages =
    Decode.map (Dict.fromList << List.map cleanupDecoderLanguage) (Decode.keyValuePairs decodeSupportedLanguage)


decodeSupportedLanguage : Decoder SupportedLanguage
decodeSupportedLanguage =
    Decode.succeed SupportedLanguage
        |> required "name" Decode.string
        |> required "nativeName" Decode.string
        |> required "isReferenceLanguage" Decode.bool


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

    t_ fakeTranslations { k = "greet", default = "Goodbye" }
    --> "Hello"

    t_ fakeTranslations { k = "wrongGreet", default = "Goodbye" }
    --> "Goodbye"

-}
t_ : Translations -> Translate
t_ translations target =
    if I18Next.hasKey translations target.k then
        I18Next.t translations target.k

    else
        target.default


{-| Attempt to translate a given key, falling back the fallback language version,
and finally to the supplied default value.

This function wraps the `t_` (which in turn wraps `t` from I18Next) to provide
a better fallback flow.

E.g.

    import I18Next
    import Json.Decode as Decode
    import Dict as Dict exposing (Dict)
    import Core.I18n exposing (t_)

    fakeFrTranslations : I18Next.Translations
    fakeFrTranslations =
        case Decode.decodeString I18Next.translationsDecoder "{ \"greet\": \"Bonjour\" }" of
            Ok t -> t
            Err _ -> I18Next.initialTranslations

    fakeEnTranslations : I18Next.Translations
    fakeEnTranslations =
        case Decode.decodeString I18Next.translationsDecoder "{ \"greet\": \"Hello\", \"goodbye\": \"Goodbye\" }" of
            Ok t -> t
            Err _ -> I18Next.initialTranslations
    fakeTranslations : Dict String I18Next.Translations
    fakeTranslations = Dict.fromList
        [ ("en", fakeEnTranslations)
        , ("fr", fakeFrTranslations)
        ]

    t "fr" fakeTranslations { k = "greet", default = "Different goodbye" }
    --> "Bonjour"

    t "fr" fakeTranslations { k = "goodbye", default = "Different goodbye" }
    --> "Goodbye"

    t "fr" fakeTranslations { k = "wrongGoodbye", default = "Different goodbye" }
    --> "Different goodbye"

-}
t : Language -> Dict String Translations -> Translate
t (Language selectedLanguage) translations target =
    let
        fallbackCase =
            case Dict.get (langToString fallbackLanguage) translations of
                Just selectedTranslations ->
                    t_ selectedTranslations target

                Nothing ->
                    target.default
    in
    case Dict.get selectedLanguage translations of
        Just selectedTranslations ->
            if I18Next.hasKey selectedTranslations target.k then
                I18Next.t selectedTranslations target.k

            else
                fallbackCase

        Nothing ->
            fallbackCase
