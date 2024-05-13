part of 'create_bloc.dart';

sealed class CreateEvent extends Equatable {
  const CreateEvent();
}

class CreatePostEvent extends CreateEvent {
  final PostModel model;

  const CreatePostEvent(this.model);

  @override
  List<Object?> get props => [];
}
