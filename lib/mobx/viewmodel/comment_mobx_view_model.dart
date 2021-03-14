import 'package:mobx/mobx.dart';

import '../../core/feature/ICommentService.dart';
import '../../core/model/comment_model.dart';

part 'comment_mobx_view_model.g.dart';

class CommentMobx = _CommentMobxBase with _$CommentMobx;

abstract class _CommentMobxBase with Store {
  ICommentService commentService;

  _CommentMobxBase({
    required this.commentService,
  }) {
    fetchItems();
  }
  @observable
  bool isLoading = false;

  @observable
  int index = 0;

  @observable
  List<CommentModel> commentItems = [];

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> fetchItems() async {
    changeLoading();
    commentItems = await commentService.fetchComments();
    changeLoading();
  }

  @action
  void incrementIndex(int index) {
    Future.microtask(() {
      this.index = index;
    });
  }
}
