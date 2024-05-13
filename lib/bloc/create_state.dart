part of 'create_bloc.dart';

@immutable
abstract class CreateState extends Equatable {
  const CreateState();
}

class CreateInitial extends CreateState {
  @override
  List<Object> get props => [];
}

class CreatePostState extends CreateState {
  final PostModel model;

  const CreatePostState(this.model);

  @override
  List<Object?> get props => [model];
}

class CreateErrorState extends CreateState{
  final String message;

  const CreateErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
