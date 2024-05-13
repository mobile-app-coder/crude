import 'package:crude/bloc/home_state.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/home_bloc.dart';
import '../models/post_model.dart';
import 'item_post.dart';

Widget viewOfHome(BuildContext context, List<PostModel> list, HomeBloc bloc) {
  return ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
      //return itemOfPost(list[index]);
      return slidableItemOfPost(list[index], bloc);
    },
  );
}
