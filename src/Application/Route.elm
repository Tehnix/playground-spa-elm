module Application.Route exposing (ItemParameters, Route(..))

{-| Our `Route` data type defines all the routes of our application,
and sets up what data is relevant for each route to contain.

When adding a new route, you will want to go through the following
steps:

  - Adding handling in the `parser`
  - Instructing `toUrl` how to convert the data type to a URL string

-}


type Route
    = Home
    | Item (Maybe ItemParameters)


type alias ItemParameters =
    { from : Maybe String
    , to : Maybe String
    }
