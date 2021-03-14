import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/feature/comments_service.dart';
import '../../core/model/comment_model.dart';
import '../../core/service/product_service.dart';
import '../../core/widget/comment_card.dart';
import '../viewmodel/comment_cubit.dart';
import 'sub_view.dart';

class CommentBlocView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit(CommentService(ProductService.instance.networkManager)),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          if (state is CommentListError) {
            state.createError(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: buildFloatingActionButton(context),
            appBar: buildAppBar(state, context),
            body: buildBody(state, context),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(CommentState state, BuildContext context) {
    return AppBar(
      leading: buildIconWidget(state),
      actions: [buildTextIndicate(state)],
      title: Text(context.watch<CommentCubit>().listCount.toString()),
    );
  }

  Widget buildTextIndicate(CommentState state) {
    if (state is CommentIndexIndicate) {
      return Text(state.index.toString());
    } else {
      return SizedBox(width: 0.0, height: 0.0);
    }
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CommentCubit>().createError();
      },
      child: Icon(Icons.access_alarm),
    );
  }

  Icon buildIconWidget(CommentState state) {
    if (state is CommentListError) {
      return Icon(Icons.error);
    } else {
      return Icon(Icons.ac_unit_rounded);
    }
  }

  Widget buildBody(CommentState state, BuildContext context) {
    if (state is CommentLoading) {
      return CircularProgressIndicator();
    } else if (state is CommentListCompleted) {
      return buildListView(state.items);
    } else {
      return buildListView(context.watch<CommentCubit>().commentItems);
    }
  }

  ListView buildListView(List<CommentModel> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        context.read<CommentCubit>().createIndex(index);
        return CommentCard(model: items[index]);
      },
    );
  }
}
