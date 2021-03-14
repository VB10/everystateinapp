import 'package:vexana/vexana.dart';

import '../model/comment_model.dart';

abstract class ICommentService {
  final INetworkManager manager;

  ICommentService(this.manager);

  Future<List<CommentModel>> fetchComments();
}
