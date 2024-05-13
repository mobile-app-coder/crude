import 'package:crude/bloc/home_bloc.dart';
import 'package:crude/bloc/home_event.dart';
import 'package:crude/bloc/home_state.dart';
import 'package:crude/services/http_service.dart';
import 'package:crude/views/errorView.dart';
import 'package:crude/views/loadingView.dart';
import 'package:crude/views/viewOfPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  delete(id) async {
    await NetworkService.delete(id);
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(LoadPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc.callCreatePage(context);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Post crud"),
          elevation: 10,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeErrorState) {
              return errorView(state.message);
            }
            if (state is HomeLoadPostState) {
              return viewOfHome(context, state.posts, bloc);
            }
            return loadingView();
          },
        ));
  }
}
