module Application.Route exposing (parser, toPageModel)

import Application.Page.Types exposing (PageModel(..))
import Application.Types as Route exposing (Route)
import Core.Types exposing (Model)
import Helper.Maybe exposing (maybe)
import Page.Home as Home
import Page.Item as Item
import Url.Parser as UrlParser exposing ((<?>), oneOf, s)
import Url.Parser.Query as Query


{-| To go from an arbitrary @String@ into our @Route@ data type, we need
to instruct Elm how to parse our routes. We construct a parser, which will
return a @Maybe@ where @Nothing@ indicates no matches, and a @Just a@ means
that we have matched on something.

E.g.

    import Url.Parser as UrlParser
    UrlParser.parse parser "item?from=test"
    --> Just (Item "test")

Consult <https://package.elm-lang.org/packages/elm/url/latest/Url-Parser> for
more in-depth information.

When adding a new route, you will want to specify how to add its parsing here.

-}
parser : UrlParser.Parser (Route -> a) a
parser =
    oneOf
        [ UrlParser.map Route.Home UrlParser.top
        , UrlParser.map (\from to -> Route.Item (Just { from = from, to = to })) (s "item" <?> Query.string "from" <?> Query.string "to")
        ]


{-| Figure out what page model we need to use, depending on the `Route`
that we are on. If the route is going to the same page, we make sure to
keep the page model we already have, instead of reinitialising it.

When adding a new page, you will want to update this with the new route
to the page.

-}
toPageModel : Maybe Model -> Maybe Route -> Maybe Route -> PageModel
toPageModel maybeModel previousRoute nextRoute =
    case ( previousRoute, nextRoute ) of
        ( _, Nothing ) ->
            NotFound

        ( Just Route.Home, Just Route.Home ) ->
            maybe (Home Home.init) .pageModel maybeModel

        ( _, Just Route.Home ) ->
            Home Home.init

        ( Just (Route.Item _), Just (Route.Item params) ) ->
            -- TODO: Find a more elegant way of achiving this.
            let
                -- Update the parameters, while retaining the model.
                updateParams m =
                    case m.pageModel of
                        Item itemModel ->
                            Item (setParams itemModel)

                        _ ->
                            m.pageModel

                setParams : Item.Model -> Item.Model
                setParams itemModel =
                    { itemModel | params = params }
            in
            maybe (Item (Item.init params)) updateParams maybeModel

        ( _, Just (Route.Item params) ) ->
            Item (Item.init params)
