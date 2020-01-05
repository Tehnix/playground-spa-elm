module Application.Page.Types exposing (PageModel(..), PageMsg(..))

import Page.Home as Home
import Page.Item as Item


{-| The `PageModel` is a union type of all pages. This allows us to
pattern match directly in our `view` function, to decide which page
we should display. Alternatively we would have to dig into the route.

When adding a new page, you will want to update this with the page
model.

-}
type PageModel
    = NotFound
    | Home Home.Model
    | Item Item.Model


{-| The `PageMsg` is a union type of all pages. This allows us to
group page updaes into the same case, and extract them from the
core update handler.

When adding a new page, you will want to update this with the page
msg.

-}
type PageMsg
    = HomeMsg Home.Msg
    | ItemMsg Item.Msg
