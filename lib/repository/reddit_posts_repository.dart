import 'dart:convert';
import 'dart:developer';

import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/models/subreddits_list_model.dart';
import 'package:readit/services/reddit_posts_service.dart';

import '../core/locator.dart';

class RedditPostsRepository {
  final RedditPostsService _redditPostsService;

  RedditPostsRepository({RedditPostsService? redditPostsService})
      : _redditPostsService =
            redditPostsService ?? locator.get<RedditPostsService>();

  Future<RedditPostsModel> getRedditPosts(int postLimit) async {
    try {
      final redditPostsResponse =
          jsonDecode(await _redditPostsService.fetchRedditPosts(postLimit))
              as Map<String, dynamic>;
      if (redditPostsResponse.containsKey('error')) {
        throw Exception(redditPostsResponse['message']);
      }
      return RedditPostsModel.fromJson(redditPostsResponse);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<String> upvoteOrDownvote(String id, int dir) async =>
      await _redditPostsService.upvoteOrDownvote(id, dir);

  Future<SubredditListModel> getListOfSubscribedSubreddits() async {
    try {
      //TODO: Try & get list of all subscribed subreddits at once
      final redditPostsResponse =
          jsonDecode(await _redditPostsService.getListOfSubscribedSubreddits())
              as Map<String, dynamic>;
      if (redditPostsResponse.containsKey('error')) {
        throw Exception(redditPostsResponse['message']);
      }
      return SubredditListModel.fromJson(redditPostsResponse);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
