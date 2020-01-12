module Api.Repositories exposing (IssueNode, IssueNodeData, Issues, Repository, query)

import Api.GitHub.Enum.IssueState exposing (IssueState(..))
import Api.GitHub.Object
import Api.GitHub.Object.Issue as Issue
import Api.GitHub.Object.IssueConnection as IssueConnection
import Api.GitHub.Object.IssueEdge as IssueEdge
import Api.GitHub.Object.Repository as Repository
import Api.GitHub.Query as Query
import Api.GitHub.ScalarCodecs
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)


query : { name : String, owner : String } -> SelectionSet Repository RootQuery
query { name, owner } =
    Query.repository { name = name, owner = owner } repositorySelection |> SelectionSet.nonNullOrFail


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
    , url : Api.GitHub.ScalarCodecs.Uri
    }


repositorySelection : SelectionSet Repository Api.GitHub.Object.Repository
repositorySelection =
    SelectionSet.map Repository
        (Repository.issues (\optionals -> { optionals | last = Present 10, states = Present [ Closed ] }) issues)


issues : SelectionSet Issues Api.GitHub.Object.IssueConnection
issues =
    SelectionSet.map Issues
        (IssueConnection.edges issuesNode |> SelectionSet.nonNullOrFail |> SelectionSet.nonNullElementsOrFail)


issuesNode : SelectionSet IssueNode Api.GitHub.Object.IssueEdge
issuesNode =
    SelectionSet.map IssueNode
        (IssueEdge.node issuesNodeData |> SelectionSet.nonNullOrFail)


issuesNodeData : SelectionSet IssueNodeData Api.GitHub.Object.Issue
issuesNodeData =
    SelectionSet.map2 IssueNodeData
        Issue.title
        Issue.url
