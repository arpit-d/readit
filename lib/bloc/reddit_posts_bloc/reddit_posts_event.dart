part of 'reddit_posts_bloc.dart';

abstract class RedditPostsEvent extends Equatable {
  const RedditPostsEvent();

  @override
  List<Object> get props => [];
}

class LoadRedditPosts extends RedditPostsEvent {
  const LoadRedditPosts();
}

class VoteRedditPosts extends RedditPostsEvent {
  final Child post;
  final int dir;
  const VoteRedditPosts({required this.post, required this.dir});
}
