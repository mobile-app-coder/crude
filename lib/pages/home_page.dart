import 'package:crude/pages/create_post_page.dart';
import 'package:crude/services/http_service.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../views/item_post.dart';

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
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CreatePostPage();
          }));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Post crud"),
        elevation: 10,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          //return itemOfPost(list[index]);
          return slidableItemOfPost(list[index]);
        },
      ),
    );
  }
}
