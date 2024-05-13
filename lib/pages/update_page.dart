import 'package:crude/bloc/update_bloc.dart';
import 'package:crude/models/post_model.dart';
import 'package:crude/services/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePage extends StatefulWidget {
  final PostModel? model;

  UpdatePage({super.key, this.model});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late UpdateBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<UpdateBloc>(context);
    _bloc.newModel = widget.model!;
    _bloc.title.text = widget.model!.title;
    _bloc.body.text = widget.model!.body;
    _bloc.stream.listen((state) {
      if (state is UpdatePostState) {
        LogService.e("Update done");
        gotoHome();
      }
    });
  }

  gotoHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: BlocBuilder<UpdateBloc, UpdateState>(
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
                    controller: _bloc.title,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text("Title")),
                    maxLines: 2,
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
                    controller: _bloc.body,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text("Body")),
                    maxLines: 6,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      _bloc.add(UpdateEvent());
                    },
                    color: Colors.grey,
                    child: const Text(
                      "Update",
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
