import 'package:crude/models/post_model.dart';
import 'package:dio/dio.dart';

class NetworkService {
  static Map<String, String> header = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  static final dio = Dio();

  //get
  static Future<List<PostModel>?> GET(
      String api, Map<String, dynamic> map) async {
    var response = await dio.get<String>(BASE + api, queryParameters: map);
    if (response.statusCode == 200) {
      List<PostModel> listPost = postModelFromJson(response.data!);
      return listPost;
    }
    return null;
  }

  //create
  static Future<PostModel?> POST(String api, Map<String, dynamic> map) async {
    var response = await dio.post(BASE + api, data: map);
    if (response.statusCode == 201) {
      PostModel post = PostModel.fromJson(response.data);
      return post;
    }
    return null;
  }

  //delete
  static Future<void> delete(int id) async {
    await dio.delete(BASE + API_LIST + "/" + id.toString());
  }

  //update
  static Future<PostModel?> UPDATE(int id,  Map map) async {
    PostModel? newModel;
    var response =
        await dio.put(BASE + API_LIST + "/" + id.toString(), data: map);

    if (response.statusCode == 200) {
      newModel = PostModel.fromJson(response.data);
    }
    return newModel;
  }

  static Map<String, dynamic> emptyParam() {
    Map<String, dynamic> map = Map();
    map.addAll({});
    return map;
  }

  static Map<String, dynamic> paramCreate(PostModel model) {
    Map<String, dynamic> map = Map();
    map.addAll(
        {"title": model.title, 'body': model.body, 'userId': model.userId});
    return map;
  }

  static Map<String, dynamic> paramUpadte(PostModel model) {
    return {
      "id": model.id,
      "title": model.title,
      "body": model.body,
      "userId": model.userId,
    };
  }

  static final BASE = "https://jsonplaceholder.typicode.com";
  static String API_LIST = "/posts";
}
