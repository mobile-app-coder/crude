part of 'update_bloc.dart';

@immutable
sealed class UpdateState extends Equatable {
  const UpdateState();
}

final class UpdateInitial extends UpdateState {
  @override
  List<Object> get props => [];
}


class UpdatePostState extends UpdateState{
  final PostModel model;

  const UpdatePostState(this.model);

  @override
  List<Object?> get props => [model];

}
class UpdateErrorState extends UpdateState{
  final String message;

  const UpdateErrorState(this.message);
  @override
  List<Object?> get props => [message];

}