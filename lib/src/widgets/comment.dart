import 'package:flutter/material.dart';
import 'package:flutter_news/src/models/item_model.dart';
import 'package:flutter_news/src/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget _buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('&#x2F;', "/")
        .replaceAll("<p>", '\n\n')
        .replaceAll("&quot;", '"');

    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return LoadingContainer();
        }

        final item = itemSnapshot.data;
        final children = <Widget>[
          ListTile(
            title: _buildText(item),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(
              left: 16.0 * (1 + depth),
              right: 16.0,
            ),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }
}
