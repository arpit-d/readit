part of 'reddit_posts_bloc.dart';

abstract class RedditPostsState extends Equatable {
  const RedditPostsState();

  @override
  List<Object> get props => [];
}

class LoadingRedditPosts extends RedditPostsState {}

class LoadedRedditPostsSuccessfully extends RedditPostsState {
  final RedditPostsModel redditPosts;

  LoadedRedditPostsSuccessfully(this.redditPosts);

  @override
  List<Object> get props => [redditPosts];
}

class RedditPostsFailed extends RedditPostsState {
  final String failedMessage;

  RedditPostsFailed({required this.failedMessage});

  @override
  List<Object> get props => [failedMessage];
}
