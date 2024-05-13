import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadPostState extends HomeState {
  final List<PostModel> posts;

  const HomeLoadPostState(this.posts);

  @override
  List<Object?> get props => [posts];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}
