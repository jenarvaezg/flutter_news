import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/comments_provider.dart';
import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail(this.itemId);

  Widget _buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }

        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Loading future");
            }

            final item = itemSnapshot.data;

            return _buildList(item, snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    return ListView(
      children: [
        _buildTitle(item),
      ]..addAll(commentsList),
    );
  }

  Widget _buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget _buildComments(
      List<int> commentIds, Map<int, Future<ItemModel>> itemMap) {
    print(commentIds);
    return Text("PEPE");
  }

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: _buildBody(bloc),
    );
  }
}
