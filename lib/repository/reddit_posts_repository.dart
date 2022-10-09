import 'dart:convert';
import 'dart:developer';

import 'package:readit/models/reddit_posts_model.dart';
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
          await _redditPostsService.fetchRedditPosts(postLimit);
      return RedditPostsModel.fromJson(
          jsonDecode(redditPostsResponse) as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
