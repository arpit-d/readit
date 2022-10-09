import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';
import 'package:readit/core/utils/snackbars.dart';
import 'package:readit/models/reddit_posts_model.dart';

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
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LeftSidePanel(),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                      itemCount: state.redditPosts.data.children.length,
                      itemBuilder: (context, index) {
                        final post = state.redditPosts.data.children[index];
                        log('Length' +
                            state.redditPosts.data.children.length.toString());
                        return index >= state.redditPosts.data.children.length
                            ? LoadingIndicator()
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: InkWell(
                                  onTap: () {},
                                  mouseCursor:
                                      MaterialStateMouseCursor.clickable,
                                  child: Card(
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    )),
                                    elevation: 12,
                                    child: Row(
                                      children: [
                                        postImageData(context, post),
                                        PostTextData(post: post),
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

  Container postImageData(BuildContext context, Child post) {
    return Container(
      padding: EdgeInsets.all(12),
      // height:
      //     MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.height * 0.25,
      child: post.data.url_overridden_by_dest == null ||
              post.data.thumbnail == 'nsfw' ||
              post.data.thumbnail == 'default'
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
              // fit: BoxFit.fill,
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
        padding: EdgeInsets.all(12),
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
  const LeftSidePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Text('aa'),
        ],
      ),
    );
  }
}
