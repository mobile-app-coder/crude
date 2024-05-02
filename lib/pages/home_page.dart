import 'package:crude/services/http_service.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> list = [];

  getPosts() async {
    List<PostModel>? response = await NetworkService.GET(
        NetworkService.API_LIST, NetworkService.emptyParam());
    if (response != null) {
      setState(() {
        list.addAll(response);
      });
    }
  }

  post(PostModel model) async {
    PostModel? response = await NetworkService.POST(
        NetworkService.API_LIST, NetworkService.paramCreate(model));
  }

  delete(id) async {
    await NetworkService.delete(id);
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      ),
      appBar: AppBar(
        title: Text("Post crud"),
        elevation:10,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return itemOfPost(list[index]);
        },
      ),
    );
  }

  Widget itemOfPost(PostModel model) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            model.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Text(
            model.body,
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }
}
