import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xFF1f1d28),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        leadingWidth: 150,
        leading: Container(
          padding: EdgeInsets.only(left: 12),
          height: 48,
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/reddit_logo.svg',
            semanticsLabel: 'Reddit Logo',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: BlocConsumer<RedditPostsBloc, RedditPostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadedRedditPostsSuccessfully) {
            //TODO: Split into separate widgets
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Column(
                    children: [
                      Text('aa'),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                      itemCount: state.redditPosts.data.children.length,
                      itemBuilder: (context, index) {
                        final post = state.redditPosts.data.children[index];
                        log(post.data.url_overridden_by_dest.toString());
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: InkWell(
                            onTap: () {},
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            child: Card(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              )),
                              elevation: 12,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.16,
                                    width: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: post.data.url_overridden_by_dest ==
                                                null ||
                                            post.data.thumbnail == 'default'
                                        ? Icon(Icons.message)
                                        : Image.network(
                                            post.data.url_overridden_by_dest
                                                    .toString()
                                                    .contains('gfycat')
                                                ? post.data
                                                        .url_overridden_by_dest
                                                        .toString() +
                                                    '.gif'
                                                : post.data.url_overridden_by_dest
                                                            .toString()
                                                            .contains(
                                                                'v.redd.it') ||
                                                        (!post.data
                                                                .url_overridden_by_dest
                                                                .toString()
                                                                .contains(
                                                                    'jpg') &&
                                                            !post.data
                                                                .url_overridden_by_dest
                                                                .toString()
                                                                .contains(
                                                                    'jpg'))
                                                    ? post.data.thumbnail
                                                        .toString()
                                                    : post.data
                                                        .url_overridden_by_dest
                                                        .toString(),
                                            // fit: BoxFit.fill,
                                          ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            post.data.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            post.data.subredditNamePrefixed +
                                                ' • ' +
                                                post.data.author,
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  // color: Colors.black,
                ),
              ],
            );
          }
          if (state is RedditPostsFailed) {
            return Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
