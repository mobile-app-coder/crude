import 'package:crude/services/http_service.dart';
import 'package:crude/services/log_service.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  PostModel? newModel = PostModel(title: "", body: "");

  gotoHome() {
    Navigator.pop(context);
  }


  createPost(PostModel model) async {
    var response = await NetworkService.POST(
        NetworkService.API_LIST, NetworkService.paramCreate(model));
    LogService.i(response.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create post"),
      ),
      body: Container(
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
                controller: title,
                decoration: const InputDecoration(
                    border: InputBorder.none, label: Text("Title")),
                maxLines: 2,
                onChanged: (text) {
                  newModel?.title = text;
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
                controller: body,
                decoration: const InputDecoration(
                    border: InputBorder.none, label: Text("Body")),
                maxLines: 6,
                onChanged: (text) {
                  newModel?.body = text;
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
                  createPost(newModel!);
                  gotoHome();
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
      ),
    );
  }
}
