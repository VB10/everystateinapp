import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/feature/comments_service.dart';
import '../../core/service/product_service.dart';
import '../../core/widget/comment_card.dart';
import '../viewmodel/comment_mobx_view_model.dart';

class CommentMobxView extends StatelessWidget {
  final CommentMobx _mobx = CommentMobx(commentService: CommentService(ProductService.instance.networkManager));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: buildObserverIndex()),
      body: buildObserverBody(),
    );
  }

  Observer buildObserverIndex() {
    return Observer(builder: (_) {
      return Text(_mobx.index.toString());
    });
  }

  Observer buildObserverBody() {
    return Observer(builder: (_) {
      return _mobx.isLoading ? CircularProgressIndicator() : buildListView();
    });
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: _mobx.commentItems.length,
        itemBuilder: (context, index) {
          _mobx.incrementIndex(index);
          return CommentCard(
            model: _mobx.commentItems[index],
          );
        });
  }
}
