module Application.Config exposing (AccessToken, Config, Stage, decoder)

import Core.I18n as I18n
import Core.I18n.Types exposing (I18n)
import Json.Decode as Decode exposing (Decoder, nullable, string)
import Json.Decode.Pipeline exposing (required)


type alias Config =
    { stage : Stage
    , apiUrl : String
    , auth : AuthConfig
    , i18n : I18n
    }


type alias AuthConfig =
    { authUrl : String
    , authClientId : String
    , accessToken : Maybe AccessToken
    }


type Stage
    = Production
    | Staging
    | Development


type AccessToken
    = AccessToken String


decoder : Decoder Config
decoder =
    Decode.succeed Config
        |> required "stage" (string |> Decode.andThen stageFromString)
        |> required "apiUrl" string
        |> required "auth" decoderAuth
        |> required "i18n" I18n.decoder


decoderAuth : Decoder AuthConfig
decoderAuth =
    Decode.succeed AuthConfig
        |> required "authUrl" string
        |> required "authClientId" string
        |> required "accessToken" (nullable accessTokenDecoder)


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
