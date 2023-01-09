part of 'vote_cubit.dart';

enum Vote { up, down, unvote }

enum VoteStatus { success, failure, initial }

class VoteState extends Equatable {
  final String id;
  final VoteStatus voteStatus;
  final int score;
  final Vote? vote;

  const VoteState(
      {required this.id,
      required this.score,
      required this.voteStatus,
      this.vote});

  @override
  List<Object> get props => [id, score, voteStatus];

  VoteState copyWith(
      {String? id, int? score, VoteStatus? voteStatus, Vote? vote}) {
    return VoteState(
      vote: vote ?? this.vote,
      id: id ?? this.id,
      score: score ?? this.score,
      voteStatus: voteStatus ?? this.voteStatus,
    );
  }
}
