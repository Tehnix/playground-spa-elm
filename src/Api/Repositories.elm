module Api.Repositories exposing (..)

import Api.GitHub.Object
import Api.GitHub.Object.Issue as Issue
import Api.GitHub.Object.IssueConnection as IssueConnection
import Api.GitHub.Object.IssueEdge as IssueEdge
import Api.GitHub.Object.Repository as Repository
import Api.GitHub.Query as Query
import Api.GitHub.Scalar exposing (Id(..))
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)


query : SelectionSet (Maybe Repository) RootQuery
query =
    Query.repository { name = "playground-elm-spa", owner = "Tehnix" } repositorySelection


type alias Repository =
    { issues : Issues
    }


type alias Issues =
    { edges : List IssueNode
    }


type alias IssueNode =
    { node : IssueNodeData
    }


type alias IssueNodeData =
    { title : String
    , url : String
    }


repositorySelection : SelectionSet Repository Api.GitHub.Object.Repository
repositorySelection =
    SelectionSet.succeed Repository
        |> with Repository.issues issues


issues =
    SelectionSet.succeed Issues
        |> with IssueConnection.edges issuesNode


issuesNode =
    SelectionSet.succeed IssueNode
        |> with IssueEdge.node issuesNodeData


issuesNodeData =
    SelectionSet.succeed IssueNodeData
        |> with Issue.title
        |> with Issue.url
