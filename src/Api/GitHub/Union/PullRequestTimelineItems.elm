-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.GitHub.Union.PullRequestTimelineItems exposing (..)

import Api.GitHub.InputObject
import Api.GitHub.Interface
import Api.GitHub.Object
import Api.GitHub.Scalar
import Api.GitHub.ScalarCodecs
import Api.GitHub.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode


type alias Fragments decodesTo =
    { onAddedToProjectEvent : SelectionSet decodesTo Api.GitHub.Object.AddedToProjectEvent
    , onAssignedEvent : SelectionSet decodesTo Api.GitHub.Object.AssignedEvent
    , onBaseRefChangedEvent : SelectionSet decodesTo Api.GitHub.Object.BaseRefChangedEvent
    , onBaseRefForcePushedEvent : SelectionSet decodesTo Api.GitHub.Object.BaseRefForcePushedEvent
    , onClosedEvent : SelectionSet decodesTo Api.GitHub.Object.ClosedEvent
    , onCommentDeletedEvent : SelectionSet decodesTo Api.GitHub.Object.CommentDeletedEvent
    , onConvertedNoteToIssueEvent : SelectionSet decodesTo Api.GitHub.Object.ConvertedNoteToIssueEvent
    , onCrossReferencedEvent : SelectionSet decodesTo Api.GitHub.Object.CrossReferencedEvent
    , onDemilestonedEvent : SelectionSet decodesTo Api.GitHub.Object.DemilestonedEvent
    , onDeployedEvent : SelectionSet decodesTo Api.GitHub.Object.DeployedEvent
    , onDeploymentEnvironmentChangedEvent : SelectionSet decodesTo Api.GitHub.Object.DeploymentEnvironmentChangedEvent
    , onHeadRefDeletedEvent : SelectionSet decodesTo Api.GitHub.Object.HeadRefDeletedEvent
    , onHeadRefForcePushedEvent : SelectionSet decodesTo Api.GitHub.Object.HeadRefForcePushedEvent
    , onHeadRefRestoredEvent : SelectionSet decodesTo Api.GitHub.Object.HeadRefRestoredEvent
    , onIssueComment : SelectionSet decodesTo Api.GitHub.Object.IssueComment
    , onLabeledEvent : SelectionSet decodesTo Api.GitHub.Object.LabeledEvent
    , onLockedEvent : SelectionSet decodesTo Api.GitHub.Object.LockedEvent
    , onMarkedAsDuplicateEvent : SelectionSet decodesTo Api.GitHub.Object.MarkedAsDuplicateEvent
    , onMentionedEvent : SelectionSet decodesTo Api.GitHub.Object.MentionedEvent
    , onMergedEvent : SelectionSet decodesTo Api.GitHub.Object.MergedEvent
    , onMilestonedEvent : SelectionSet decodesTo Api.GitHub.Object.MilestonedEvent
    , onMovedColumnsInProjectEvent : SelectionSet decodesTo Api.GitHub.Object.MovedColumnsInProjectEvent
    , onPinnedEvent : SelectionSet decodesTo Api.GitHub.Object.PinnedEvent
    , onPullRequestCommit : SelectionSet decodesTo Api.GitHub.Object.PullRequestCommit
    , onPullRequestCommitCommentThread : SelectionSet decodesTo Api.GitHub.Object.PullRequestCommitCommentThread
    , onPullRequestReview : SelectionSet decodesTo Api.GitHub.Object.PullRequestReview
    , onPullRequestReviewThread : SelectionSet decodesTo Api.GitHub.Object.PullRequestReviewThread
    , onPullRequestRevisionMarker : SelectionSet decodesTo Api.GitHub.Object.PullRequestRevisionMarker
    , onReadyForReviewEvent : SelectionSet decodesTo Api.GitHub.Object.ReadyForReviewEvent
    , onReferencedEvent : SelectionSet decodesTo Api.GitHub.Object.ReferencedEvent
    , onRemovedFromProjectEvent : SelectionSet decodesTo Api.GitHub.Object.RemovedFromProjectEvent
    , onRenamedTitleEvent : SelectionSet decodesTo Api.GitHub.Object.RenamedTitleEvent
    , onReopenedEvent : SelectionSet decodesTo Api.GitHub.Object.ReopenedEvent
    , onReviewDismissedEvent : SelectionSet decodesTo Api.GitHub.Object.ReviewDismissedEvent
    , onReviewRequestRemovedEvent : SelectionSet decodesTo Api.GitHub.Object.ReviewRequestRemovedEvent
    , onReviewRequestedEvent : SelectionSet decodesTo Api.GitHub.Object.ReviewRequestedEvent
    , onSubscribedEvent : SelectionSet decodesTo Api.GitHub.Object.SubscribedEvent
    , onTransferredEvent : SelectionSet decodesTo Api.GitHub.Object.TransferredEvent
    , onUnassignedEvent : SelectionSet decodesTo Api.GitHub.Object.UnassignedEvent
    , onUnlabeledEvent : SelectionSet decodesTo Api.GitHub.Object.UnlabeledEvent
    , onUnlockedEvent : SelectionSet decodesTo Api.GitHub.Object.UnlockedEvent
    , onUnpinnedEvent : SelectionSet decodesTo Api.GitHub.Object.UnpinnedEvent
    , onUnsubscribedEvent : SelectionSet decodesTo Api.GitHub.Object.UnsubscribedEvent
    , onUserBlockedEvent : SelectionSet decodesTo Api.GitHub.Object.UserBlockedEvent
    }


{-| Build up a selection for this Union by passing in a Fragments record.
-}
fragments :
    Fragments decodesTo
    -> SelectionSet decodesTo Api.GitHub.Union.PullRequestTimelineItems
fragments selections =
    Object.exhaustiveFragmentSelection
        [ Object.buildFragment "AddedToProjectEvent" selections.onAddedToProjectEvent
        , Object.buildFragment "AssignedEvent" selections.onAssignedEvent
        , Object.buildFragment "BaseRefChangedEvent" selections.onBaseRefChangedEvent
        , Object.buildFragment "BaseRefForcePushedEvent" selections.onBaseRefForcePushedEvent
        , Object.buildFragment "ClosedEvent" selections.onClosedEvent
        , Object.buildFragment "CommentDeletedEvent" selections.onCommentDeletedEvent
        , Object.buildFragment "ConvertedNoteToIssueEvent" selections.onConvertedNoteToIssueEvent
        , Object.buildFragment "CrossReferencedEvent" selections.onCrossReferencedEvent
        , Object.buildFragment "DemilestonedEvent" selections.onDemilestonedEvent
        , Object.buildFragment "DeployedEvent" selections.onDeployedEvent
        , Object.buildFragment "DeploymentEnvironmentChangedEvent" selections.onDeploymentEnvironmentChangedEvent
        , Object.buildFragment "HeadRefDeletedEvent" selections.onHeadRefDeletedEvent
        , Object.buildFragment "HeadRefForcePushedEvent" selections.onHeadRefForcePushedEvent
        , Object.buildFragment "HeadRefRestoredEvent" selections.onHeadRefRestoredEvent
        , Object.buildFragment "IssueComment" selections.onIssueComment
        , Object.buildFragment "LabeledEvent" selections.onLabeledEvent
        , Object.buildFragment "LockedEvent" selections.onLockedEvent
        , Object.buildFragment "MarkedAsDuplicateEvent" selections.onMarkedAsDuplicateEvent
        , Object.buildFragment "MentionedEvent" selections.onMentionedEvent
        , Object.buildFragment "MergedEvent" selections.onMergedEvent
        , Object.buildFragment "MilestonedEvent" selections.onMilestonedEvent
        , Object.buildFragment "MovedColumnsInProjectEvent" selections.onMovedColumnsInProjectEvent
        , Object.buildFragment "PinnedEvent" selections.onPinnedEvent
        , Object.buildFragment "PullRequestCommit" selections.onPullRequestCommit
        , Object.buildFragment "PullRequestCommitCommentThread" selections.onPullRequestCommitCommentThread
        , Object.buildFragment "PullRequestReview" selections.onPullRequestReview
        , Object.buildFragment "PullRequestReviewThread" selections.onPullRequestReviewThread
        , Object.buildFragment "PullRequestRevisionMarker" selections.onPullRequestRevisionMarker
        , Object.buildFragment "ReadyForReviewEvent" selections.onReadyForReviewEvent
        , Object.buildFragment "ReferencedEvent" selections.onReferencedEvent
        , Object.buildFragment "RemovedFromProjectEvent" selections.onRemovedFromProjectEvent
        , Object.buildFragment "RenamedTitleEvent" selections.onRenamedTitleEvent
        , Object.buildFragment "ReopenedEvent" selections.onReopenedEvent
        , Object.buildFragment "ReviewDismissedEvent" selections.onReviewDismissedEvent
        , Object.buildFragment "ReviewRequestRemovedEvent" selections.onReviewRequestRemovedEvent
        , Object.buildFragment "ReviewRequestedEvent" selections.onReviewRequestedEvent
        , Object.buildFragment "SubscribedEvent" selections.onSubscribedEvent
        , Object.buildFragment "TransferredEvent" selections.onTransferredEvent
        , Object.buildFragment "UnassignedEvent" selections.onUnassignedEvent
        , Object.buildFragment "UnlabeledEvent" selections.onUnlabeledEvent
        , Object.buildFragment "UnlockedEvent" selections.onUnlockedEvent
        , Object.buildFragment "UnpinnedEvent" selections.onUnpinnedEvent
        , Object.buildFragment "UnsubscribedEvent" selections.onUnsubscribedEvent
        , Object.buildFragment "UserBlockedEvent" selections.onUserBlockedEvent
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    { onAddedToProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onAssignedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBaseRefChangedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBaseRefForcePushedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onClosedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCommentDeletedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onConvertedNoteToIssueEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCrossReferencedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDemilestonedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeployedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeploymentEnvironmentChangedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefDeletedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefForcePushedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefRestoredEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onIssueComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLabeledEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLockedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMarkedAsDuplicateEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMentionedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMergedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMilestonedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMovedColumnsInProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPinnedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestCommit = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestCommitCommentThread = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestReview = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestReviewThread = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestRevisionMarker = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReadyForReviewEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReferencedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRemovedFromProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRenamedTitleEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReopenedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewDismissedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewRequestRemovedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewRequestedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onSubscribedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onTransferredEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnassignedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnlabeledEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnlockedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnpinnedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnsubscribedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUserBlockedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }
