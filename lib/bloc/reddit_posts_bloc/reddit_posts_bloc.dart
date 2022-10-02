import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/repository/reddit_posts_repository.dart';

part 'reddit_posts_event.dart';
part 'reddit_posts_state.dart';

class RedditPostsBloc extends Bloc<RedditPostsEvent, RedditPostsState> {
  final RedditPostsRepository _postsRepository;
  RedditPostsBloc(this._postsRepository) : super(LoadingRedditPosts()) {
    on<LoadRedditPosts>(_loadRedditPosts);
  }

  void _loadRedditPosts(
      LoadRedditPosts event, Emitter<RedditPostsState> emit) async {
    try {
      final redditPosts = await _postsRepository.getRedditPosts();
      emit(LoadedRedditPostsSuccessfully(await redditPosts));
    } catch (e) {
      log(e.toString());
      emit(RedditPostsFailed());
    }
  }
}
