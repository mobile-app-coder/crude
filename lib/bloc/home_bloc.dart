import 'package:crude/bloc/create_bloc.dart';
import 'package:crude/bloc/update_bloc.dart';
import 'package:crude/pages/update_page.dart';
import 'package:crude/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../pages/create_post_page.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<PostModel> list = [];

  HomeBloc() : super(HomeInitial()) {
    on<LoadPostEvent>(_loadPosts);
  }

  Future<void> _loadPosts(LoadPostEvent event, Emitter<HomeState> emit) async {
    var response = await NetworkService.GET(NetworkService.API_LIST, {});
    if (response != null) {
      list.addAll(response);
      emit(HomeLoadPostState(list));
    } else {
      emit(const HomeErrorState("No data"));
    }
  }

  Future callCreatePage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => CreateBloc(),
        child: const CreatePostPage(),
      );
    }));
  }

  Future callUpdatePage(BuildContext context, PostModel model) async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UpdateBloc(),
        child: UpdatePage(
          model: model,
        ),
      );
    }));
  }
}
