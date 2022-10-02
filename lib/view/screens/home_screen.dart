import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1d28),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            onPressed: () => context.read<AuthBloc>().add(AuthSignOutEvent()),
            child: Text('Sign Out'),
          ),
        ],
        centerTitle: true,
        title: Text('Home'),
      ),
      body: BlocConsumer<RedditPostsBloc, RedditPostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadedRedditPostsSuccessfully) {
            return ListView.builder(
                itemCount: state.redditPosts.data.children.length,
                itemBuilder: (context, index) {
                  final post = state.redditPosts.data.children[index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            post.data.subredditNamePrefixed,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '•',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            post.data.author,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        post.data.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        post.data.selftext,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                });
          }
          if (state is RedditPostsFailed) {
            return Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
