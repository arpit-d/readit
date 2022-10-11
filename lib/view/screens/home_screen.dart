import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';
import 'package:readit/core/utils/snackbars.dart';
import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/models/subreddits_list_model.dart' as sb;

import '../../bloc/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

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
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoadingRedditPosts) {
            showSnackbar(context,
                message: 'Loading More Posts!',
                snackbarType: SnackbarType.success);
          }
          if (state is RedditPostsFailed) {
            showSnackbar(context,
                message: 'Failed To Load Posts, Please Try Again!',
                snackbarType: SnackbarType.success);
          }
        },
        builder: (context, state) {
          if (state is LoadedRedditPostsSuccessfully) {
            //TODO: Split into separate widgets

            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return postsList(context, state, constraints);
              }
              final subscribedSubredditList = state.subscribedSubredditList;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LeftSidePanel(state: subscribedSubredditList),
                  postsList(context, state, constraints),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    // color: Colors.black,
                  ),
                ],
              );
            });
          }
          if (state is RedditPostsFailed) {
            final errorState = state.failedMessage;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something went wrong! \n$errorState',
                    style: TextStyle(),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () =>
                        context.read<RedditPostsBloc>().add(LoadRedditPosts()),
                    child: Text(
                      'Try Reloading!',
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: LoadingIndicator(),
          );
        },
      ),
    );
  }

  Container postsList(BuildContext context, LoadedRedditPostsSuccessfully state,
      BoxConstraints constraints) {
    return Container(
      color: Colors.white,
      width: constraints.maxWidth < 600
          ? double.infinity
          : MediaQuery.of(context).size.width * 0.6,
      child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) => SizedBox(
                height: constraints.maxWidth < 600 ? 6 : 8,
              ),
          itemCount: state.redditPosts.data.children.length,
          itemBuilder: (context, index) {
            final post = state.redditPosts.data.children[index];
            return index >= state.redditPosts.data.children.length
                ? LoadingIndicator()
                : SizedBox(
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
                            postImageData(context, post, constraints),
                            PostTextData(post: post),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  Container postImageData(
      BuildContext context, Child post, BoxConstraints constraints) {
    return Container(
      // height:
      //     MediaQuery.of(context).size.height * 0.16,
      width: constraints.maxWidth < 600
          ? MediaQuery.of(context).size.height * 0.15
          : MediaQuery.of(context).size.height * 0.25,
      child: post.data.url_overridden_by_dest == null ||
              post.data.thumbnail == 'nsfw' ||
              post.data.thumbnail == 'default' ||
              post.data.thumbnail == 'spoiler'
          ? Icon(Icons.message)
          : Image.network(
              post.data.url_overridden_by_dest.toString().contains('gfycat')
                  ? post.data.url_overridden_by_dest.toString() + '.gif'
                  : post.data.url_overridden_by_dest
                              .toString()
                              .contains('v.redd.it') ||
                          (!post.data.url_overridden_by_dest
                                  .toString()
                                  .contains('jpg') &&
                              !post.data.url_overridden_by_dest
                                  .toString()
                                  .contains('jpg'))
                      ? post.data.thumbnail.toString()
                      : post.data.url_overridden_by_dest.toString(),
              fit: BoxFit.cover,
            ),
    );
  }

  void _onScroll() {
    log(_isBottom.toString());
    if (_isBottom) context.read<RedditPostsBloc>().add(LoadRedditPosts());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class PostTextData extends StatelessWidget {
  const PostTextData({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Child post;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post.data.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              post.data.subredditNamePrefixed + ' • ' + post.data.author,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

class LeftSidePanel extends StatelessWidget {
  final sb.SubredditListModel state;
  const LeftSidePanel({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
      width: MediaQuery.of(context).size.width * 0.2,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
          itemCount: state.data.children.length,
          itemBuilder: (context, index) {
            final subscribedSubreddit = state.data.children[index];
            final pos = subscribedSubreddit.data.communityIcon!.indexOf('?');
            final slicedCommunityIconLink = (pos != -1
                ? subscribedSubreddit.data.communityIcon!.substring(0, pos)
                : null);
            return Row(
              children: [
                CircleAvatar(
                  backgroundColor: slicedCommunityIconLink == null
                      ? Colors.blue
                      : Colors.white,
                  radius: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: slicedCommunityIconLink == null
                        ? Text(
                            'R',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        : Image.network(
                            slicedCommunityIconLink,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Text(
                    subscribedSubreddit.data.displayName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
