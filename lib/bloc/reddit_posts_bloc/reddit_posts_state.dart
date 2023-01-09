part of 'reddit_posts_bloc.dart';

abstract class RedditPostsState extends Equatable {
  const RedditPostsState();

  @override
  List<Object> get props => [];
}

class LoadingRedditPosts extends RedditPostsState {}

class LoadedRedditPostsSuccessfully extends RedditPostsState {
  final RedditPostsModel redditPosts;
  final sb.SubredditListModel subscribedSubredditList;

  LoadedRedditPostsSuccessfully(
      {required this.redditPosts, required this.subscribedSubredditList});

  @override
  List<Object> get props => [redditPosts, subscribedSubredditList];
}

class RedditPostsFailed extends RedditPostsState {
  final String failedMessage;

  RedditPostsFailed({required this.failedMessage});

  @override
  List<Object> get props => [failedMessage];
}
