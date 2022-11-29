import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';
import 'package:readit/core/utils/snackbars.dart';
import 'package:readit/models/reddit_posts_model.dart';
import 'package:readit/models/subreddits_list_model.dart' as sb;
import 'package:readit/view/screens/image_viewer.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../cubit/user_data_cubit.dart';

enum Menu { profile, settings, signOut }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final ScrollController _scrollController = ScrollController();
  // @override
  // void initState() {
  //   _scrollController.addListener(_onScroll);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            final subscribedSubredditList = state.subscribedSubredditList;
            return LayoutBuilder(builder: (context, constraints) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {},
                ),
                drawer: constraints.maxWidth < 600
                    ? Drawer(
                        child: LeftSidePanel(state: subscribedSubredditList),
                      )
                    : null,
                appBar: customAppbar(context),
                body: (constraints.maxWidth < 600)
                    ? postsList(context, state, constraints)
                    : Row(
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
                      ),
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

  AppBar customAppbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'R E A D I T',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        PopupMenuButton<Menu>(
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLoadedState) {
                final data = state.userData;
                return CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      '${data.iconImg}',
                    ),
                  ),
                );
              }
              return CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
              );
            },
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
            PopupMenuItem<Menu>(
              value: Menu.profile,
              child: Text('Profile'),
              onTap: () => context.go("/profile"),
            ),
            PopupMenuItem<Menu>(
              value: Menu.signOut,
              child: Text('Sign Out'),
              onTap: () => context.read<AuthBloc>().add(AuthSignOutEvent()),
            ),
          ],
        ),
        SizedBox(
          width: 12,
        ),
        // ElevatedButton(
        //   onPressed: () => context.read<AuthBloc>().add(AuthSignOutEvent()),
        //   child: Text('Sign Out'),
        // ),
      ],
      // leadingWidth: 150,
      // leading: Container(
      //   padding: EdgeInsets.only(left: 12),
      //   height: 48,
      //   width: double.infinity,
      //   child: SvgPicture.asset(
      //     'assets/reddit_logo.svg',
      //     semanticsLabel: 'Reddit Logo',
      //     fit: BoxFit.contain,
      //   ),
      // ),
    );
  }

  Container postsList(BuildContext context, LoadedRedditPostsSuccessfully state,
      BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth < 600
          ? double.infinity
          : MediaQuery.of(context).size.width * 0.6,
      child: ListView.separated(
          //  controller: _scrollController,
          separatorBuilder: (context, index) => SizedBox(
                height: constraints.maxWidth < 600 ? 6 : 8,
              ),
          itemCount: state.redditPosts.data.children.length,
          itemBuilder: (context, index) {
            final post = state.redditPosts.data.children[index];
            return Card(
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
              elevation: 0,
              child: InkWell(
                onTap: () {},
                mouseCursor: MaterialStateMouseCursor.clickable,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment:
                          post.data.url_overridden_by_dest == null ||
                                  post.data.thumbnail == 'nsfw' ||
                                  post.data.thumbnail == 'default' ||
                                  post.data.thumbnail == 'spoiler'
                              ? CrossAxisAlignment
                                  .center //to center the msg box icon
                              : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        postImageData(context, post, constraints),
                        PostTextData(post: post),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${post.data.score} points',
                          ),
                          Text(
                            '${post.data.numComments} comments',
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_upward_outlined),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_downward_outlined),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.bookmark_outline_outlined),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    )
                  ],
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
          ? Center(
              child: Icon(Icons.message),
            )
          // TODO: Clean this up
          : InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ImageViewer(
                    heroID: '${post.data.id}',
                    photoURL: post.data.url_overridden_by_dest
                            .toString()
                            .contains('gfycat')
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
                  ),
                ),
              ),
              child: Hero(
                tag: '${post.data.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post.data.url_overridden_by_dest
                            .toString()
                            .contains('gfycat')
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
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
    );
  }

  // void _onScroll() {
  //   if (_isBottom) context.read<RedditPostsBloc>().add(LoadRedditPosts());
  // }

  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll);
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
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
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post.data.title.replaceAll('&amp;', '&'),
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text(
                  post.data.subredditNamePrefixed + ' ',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '• ' + post.data.author,
                ),
                if (post.data.linkFlairText != null)
                  Text(
                    ' • ' + post.data.linkFlairText!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
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
                      ? Theme.of(context).primaryColor
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
