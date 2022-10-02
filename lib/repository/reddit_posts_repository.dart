import 'dart:convert';
import 'dart:developer';

import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/services/reddit_posts_service.dart';

class RedditPostsRepository {
  final RedditPostsService _redditPostsService;

  RedditPostsRepository(this._redditPostsService);
  Future<RedditPostsModel> getRedditPosts() async {
    try {
      final redditPostsResponse = await _redditPostsService.fetchRedditPosts();
      return RedditPostsModel.fromJson(
          jsonDecode(await redditPostsResponse) as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
