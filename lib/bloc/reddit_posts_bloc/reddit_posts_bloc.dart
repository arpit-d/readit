import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/models/subreddits_list_model.dart' as sb;
import 'package:readit/repository/reddit_posts_repository.dart';

part 'reddit_posts_event.dart';
part 'reddit_posts_state.dart';

class RedditPostsBloc extends Bloc<RedditPostsEvent, RedditPostsState> {
  final RedditPostsRepository _postsRepository;
  int postLimit = 20;
  bool isFetching = false;

  RedditPostsBloc(this._postsRepository) : super(LoadingRedditPosts()) {
    on<LoadRedditPosts>(_loadRedditPosts);
  }

  void _loadRedditPosts(
      LoadRedditPosts event, Emitter<RedditPostsState> emit) async {
    try {
      final redditPosts = await _postsRepository.getRedditPosts(postLimit);
      final subscribedSubreddits =
          await _postsRepository.getListOfSubscribedSubreddits();
      emit(LoadedRedditPostsSuccessfully(
          redditPosts: redditPosts,
          subscribedSubredditList: subscribedSubreddits));
      postLimit += 10;
    } catch (e) {
      log(e.toString());
      emit(RedditPostsFailed(failedMessage: e.toString().substring(11)));
    }
  }
}
