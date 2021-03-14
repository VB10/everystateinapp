import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/feature/ICommentService.dart';
import '../../core/model/comment_model.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.commentService) : super(CommentInitial()) {
    fetchItems();
  }

  ICommentService commentService;
  int listCount = 0;
  List<CommentModel> commentItems = [];

  Future<void> fetchItems() async {
    emit(CommentLoading());
    commentItems = await commentService.fetchComments();
    listCount = commentItems.length;
    emit(CommentListCompleted(commentItems));
    // if (list.isEmpty) {
    //   emit(CommentListError());
    // }
  }

  Future<void> createError() async {
    await Future.delayed(Duration(seconds: 5));
    emit(CommentListError());
  }

  Future<void> createIndex(int index) async {
    emit(CommentIndexIndicate(index));
  }
}

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentListCompleted extends CommentState {
  final List<CommentModel> items;

  CommentListCompleted(this.items);
}

class CommentListError extends CommentState {}

class CommentIndexIndicate extends CommentState {
  final int index;

  CommentIndexIndicate(this.index);
}
