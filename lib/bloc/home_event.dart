import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class LoadPostEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
