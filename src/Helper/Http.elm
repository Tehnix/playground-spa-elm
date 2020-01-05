module Helper.Http exposing (get)

import Http


get :
    { url : String
    , expect : Http.Expect msg
    }
    -> Cmd msg
get { url, expect } =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Accept" "application/json, text/javascript" ]
        , url = url
        , body = Http.emptyBody
        , expect = expect
        , timeout = Nothing
        , tracker = Nothing
        }
