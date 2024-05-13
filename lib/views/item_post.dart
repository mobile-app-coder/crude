import 'package:crude/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/post_model.dart';

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

Widget slidableItemOfPost(PostModel model, HomeBloc bloc) {
  //final controller = SlidableController();
  return Slidable(
    // Specify a key if the Slidable is dismissible.
    key: const ValueKey(0),

    // The start action pane is the one at the left or the top side.
    startActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),

      // A pane can dismiss the Slidable.
      dismissible: DismissiblePane(onDismissed: () {}),

      // All actions are defined in the children parameter.
      children: [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),

    // The end action pane is the one at the right or the bottom side.
    endActionPane: ActionPane(
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          backgroundColor: Color(0xFF0392CF),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
          onPressed: (context) {
            bloc.callUpdatePage(context, model);
          },
        ),
      ],
    ),

    // The child of the Slidable is what the user sees when the
    // component is not dragged.
    child: itemOfPost(model),
  );
}
