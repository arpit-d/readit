part of 'reddit_posts_bloc.dart';

abstract class RedditPostsEvent extends Equatable {
  const RedditPostsEvent();

  @override
  List<Object> get props => [];
}

class LoadRedditPosts extends RedditPostsEvent {
  const LoadRedditPosts();
}

class RedditPostsLoaded extends RedditPostsEvent {
  const RedditPostsLoaded();
}

class RedditPostsFailure extends RedditPostsEvent {
  const RedditPostsFailure();
}
