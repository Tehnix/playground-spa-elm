module Application.I18n.Hardcoded exposing (supportedLanguages, translations)

{-| Hardcoded translations are convenient, because you are not reliant on a
external service to fetch translations and you can initialize the application
much quicker.
-}

import Application.I18n.Types exposing (Language)
import Dict as Dict exposing (Dict)
import I18Next exposing (Translations, initialTranslations)


{-| The supported translations in the application. Make sure to add the language
to your translations dictionary as well, after adding it here.
-}
supportedLanguages : List String
supportedLanguages =
    [ "en"
    , "de"
    , "it"
    ]


{-| The available translations.
-}
translations : Dict Language Translations
translations =
    Dict.singleton "en" langEn


{-| Your translations for the specific language. It will be beneficial to move this
out into its own file, if you decide to use hardcoded translations.
-}
langEn : Translations
langEn =
    -- NOTE: Until https://github.com/ChristophP/elm-i18next/pull/20 is merged, we leave
    -- this as a blank implementation, using `initialTranslations`.
    -- let
    --     text =
    --         [ ( "sharedTextToReverse", "Text To Reverse" )
    --         , ( "sharedReverseText", "Reverse Text" )
    --         , ( "titleItem", "Item!" )
    --         , ( "titleNotFound", "Not Found!" )
    --         ]
    -- in
    -- Translations <|
    --     Dict.fromList
    --         text
    initialTranslations
