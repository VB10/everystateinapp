import 'package:flutter/material.dart';

import '../model/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel model;

  const CommentCard({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Card(
        child: ListTile(
          leading: Text(model.id.toString()),
          title: Text(model.body ?? ''),
          subtitle: Text(model.email ?? ''),
        ),
      ),
    );
  }
}
