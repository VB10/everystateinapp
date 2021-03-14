import 'package:flutter/material.dart';

import '../../core/feature/ICommentService.dart';
import '../../core/feature/comments_service.dart';
import '../../core/model/comment_model.dart';
import '../../core/service/product_service.dart';
import '../../core/widget/comment_card.dart';

class TodoVanillaView extends StatefulWidget {
  @override
  _TodoVanillaViewState createState() => _TodoVanillaViewState();
}

class _TodoVanillaViewState extends State<TodoVanillaView> {
  List<CommentModel> comments = [];

  int index = 0;

  bool isLoading = false;
  late final ICommentService commentService;

  @override
  void initState() {
    super.initState();
    commentService = CommentService(ProductService.instance.networkManager);
    _getListItem();
  }

  Future<void> _getListItem() async {
    _changeLoading();
    comments = await commentService.fetchComments();
    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _changeIndex(int index) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (comments.length - 1 == index) {
        await Future.delayed(Duration(seconds: 10));
        comments.add(CommentModel(body: '123123', email: 'asdasd', name: 'sadasd', postId: 123123));
        setState(() {});
      } else {
        setState(() {
          this.index = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Text(index.toString()),
        ),
        title: Text('Vanilla View', style: Theme.of(context).primaryTextTheme.headline4),
      ),
      body: buildScrollbar(),
    );
  }

  Scrollbar buildScrollbar() {
    return Scrollbar(
      child: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        _changeIndex(index);
        return comments.length - 1 == index ? CircularProgressIndicator() : CommentCard(model: comments[index]);
      },
    );
  }
}
