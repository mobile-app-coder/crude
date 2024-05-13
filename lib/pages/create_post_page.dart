import 'package:crude/bloc/create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late CreateBloc bloc;


  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CreateBloc>(context);
  }

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create post"),
      ),
      body: BlocBuilder<CreateBloc, CreateState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2)),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: bloc.title,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text("Title")),
                    maxLines: 2,
                    onChanged: (text) {
                      bloc.newModel.title = text;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: bloc.body,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text("Body")),
                    maxLines: 6,
                    onChanged: (text) {
                      bloc.newModel.body = text;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      bloc.add(CreatePostEvent(PostModel(
                          body: bloc.body.text,
                          title: bloc.title.text)));
                      backToFinish();
                    },
                    color: Colors.grey,
                    child: const Text(
                      "Create post",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
