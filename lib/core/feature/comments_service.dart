import 'package:vexana/src/interface/INetworkService.dart';
import 'package:vexana/vexana.dart';

import '../exception/network_path_not_found.dart';
import '../model/comment_model.dart';
import 'ICommentService.dart';

class CommentService extends ICommentService {
  CommentService(INetworkManager manager) : super(manager);

  @override
  Future<List<CommentModel>> fetchComments() async {
    final response =
        await manager.send<CommentModel, List<CommentModel>>(NetworkPath.COMMENTS.rawValue(), parseModel: CommentModel(), method: RequestType.GET);

    return response.data ?? [];
  }
}

enum NetworkPath { COMMENTS, Hello }

extension NetworkPathExtension on NetworkPath {
  String rawValue() {
    switch (this) {
      case NetworkPath.COMMENTS:
        return 'comments';
      default:
        throw NetworkPathException(this);
    }
  }
}
