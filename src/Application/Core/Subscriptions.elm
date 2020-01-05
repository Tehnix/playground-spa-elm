module Application.Core.Subscriptions exposing (subscriptions)

import Application.Core.Types exposing (Application(..), Model, Msg(..))


{-| All externally updated events go through the subscription handler, meaning
each of the events will be handled in a case here. This can be things like a
timer that ticks every second, or similar.
-}
subscriptions : Application -> Sub Msg
subscriptions application =
    case application of
        Ready model ->
            subscriptionsModel model

        _ ->
            Sub.none


subscriptionsModel : Model -> Sub Msg
subscriptionsModel _ =
    Sub.none
