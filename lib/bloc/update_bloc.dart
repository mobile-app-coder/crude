import 'package:bloc/bloc.dart';
import 'package:crude/models/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  PostModel? newModel;

  UpdateBloc() : super(UpdateInitial()) {
    on<UpdateEvent>(_update);
  }

  Future<void> _update(UpdateEvent event, Emitter<UpdateState> emit) async {
    newModel!.title = title.text;
    newModel!.body = body.text;
    var response = await NetworkService.UPDATE(
        newModel!.id!, NetworkService.paramUpadte(newModel!));
    if (response != null) {
      LogService.i(response.toString());
      emit(UpdatePostState(response));
    } else {
      emit(UpdateErrorState("no update"));
    }
  }
}
