module Core.Config exposing (AccessToken, Config, ConfigLoadState(..), Stage, decoder, failedConfig)

import Core.I18n as I18n exposing (I18n)
import I18Next exposing (initialTranslations)
import Json.Decode as Decode exposing (Decoder, nullable, string)
import Json.Decode.Pipeline exposing (hardcoded, required)


type alias Config =
    { stage : Stage
    , apiUrl : String
    , accessToken : Maybe AccessToken
    , i18n : I18n
    , loadState : ConfigLoadState
    }


{-| We want it to be easy to work with the configuration throughout the program,
so instead of wrapping it in a `Maybe`, and needing to always unwrap that, we
add a field that indicates the state of the configuration decoding.

We can then later check for this specific field, and instruct the user what to
do in this unlikely scenario.

-}
type ConfigLoadState
    = ConfigLoaded
    | FailedToDecode String


type Stage
    = Production
    | Staging
    | Development


type AccessToken
    = AccessToken String


failedConfig : String -> Config
failedConfig err =
    { stage = Development
    , apiUrl = ""
    , accessToken = Nothing
    , i18n =
        { translations = initialTranslations
        , supportedLanguages = []
        , selectedLanguage = ""
        }
    , loadState = FailedToDecode err
    }


decoder : Decoder Config
decoder =
    Decode.succeed Config
        |> required "stage" (string |> Decode.andThen stageFromString)
        |> required "apiUrl" string
        |> required "accessToken" (nullable accessTokenDecoder)
        |> required "i18n" I18n.decoder
        |> hardcoded ConfigLoaded


accessTokenDecoder : Decoder AccessToken
accessTokenDecoder =
    Decode.map AccessToken string


stageFromString : String -> Decoder Stage
stageFromString stage =
    case stage of
        "production" ->
            Decode.succeed Production

        "staging" ->
            Decode.succeed Staging

        "development" ->
            Decode.succeed Development

        _ ->
            Decode.fail ("Invalid stage: " ++ stage)
