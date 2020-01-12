module Api.Query exposing (makeRequest)

import Application.Config exposing (AccessToken(..), Config)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import RemoteData exposing (RemoteData)


makeRequest : Config -> SelectionSet response RootQuery -> (RemoteData (Graphql.Http.Error response) response -> msg) -> Cmd msg
makeRequest config query msg =
    let
        accessToken =
            case config.auth.accessToken of
                Just (AccessToken a) ->
                    a

                Nothing ->
                    ""
    in
    query
        |> Graphql.Http.queryRequest config.apiUrl
        |> Graphql.Http.withHeader "Authorization" ("Bearer " ++ accessToken)
        |> Graphql.Http.send (RemoteData.fromResult >> msg)
