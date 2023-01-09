import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readit/repository/reddit_posts_repository.dart';

part 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  VoteCubit(
      {required this.id,
      required this.score,
      required this.redditPostsRepository})
      : super(
          VoteState(id: id, score: score, voteStatus: VoteStatus.initial),
        );

  final String id;

  final int score;

  final RedditPostsRepository redditPostsRepository;

  Future<void> vote(int dir) async {
    final bool response =
        await redditPostsRepository.upvoteOrDownvote(state.id, dir);
    print(response);
    if (response) {
      emit(
        state.copyWith(
            score: dir == 1 ? state.score + 1 : state.score - 1,
            voteStatus: VoteStatus.success,
            vote: dir == 1 ? Vote.up : Vote.down),
      );
      print(state.score);
    }
  }
}
