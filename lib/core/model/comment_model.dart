import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends INetworkModel<CommentModel> {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentModel({this.postId, this.id, this.name, this.email, this.body});

  @override
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  CommentModel fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }
}
