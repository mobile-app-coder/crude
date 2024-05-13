import 'package:bloc/bloc.dart';
import 'package:crude/models/post_model.dart';
import 'package:crude/services/http_service.dart';
import 'package:crude/services/log_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitial()) {
    on<CreatePostEvent>(_createNewPost);
  }

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  PostModel newModel = PostModel(title: "", body: "");

  Future<void> _createNewPost(
    CreatePostEvent event,
    Emitter<CreateState> emit,
  ) async {
    var response = await NetworkService.POST(
        NetworkService.API_LIST,
        NetworkService.paramCreate(
            PostModel(title: title.text, body: body.text)));

    if (response != null) {
      LogService.i(response.toString());
      newModel = response;
      emit(CreatePostState(newModel));
    } else {
      emit(const CreateErrorState("No new post"));
    }
  }
}
