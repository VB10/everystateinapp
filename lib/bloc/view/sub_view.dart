import 'package:flutter/material.dart';

import '../viewmodel/comment_cubit.dart';

extension CommentListErrorExtension on CommentListError {
  void createError(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Text('data'),
      ),
    );
  }
}
