import 'package:crude/models/post_model.dart';
import 'package:crude/services/http_service.dart';
import 'package:crude/services/log_service.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final PostModel? model;

  UpdatePage({super.key, this.model});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  PostModel? newModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.model!.title;
    body.text = widget.model!.body;
    newModel = widget.model!;
  }

  update(PostModel model) async {
    var response = await NetworkService.UPDATE(
        widget.model!.id!, NetworkService.paramUpadte(model));
    LogService.i(response.toString());
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
                  update(newModel!);
                  gotoHome();
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
      ),
    );
  }
}
