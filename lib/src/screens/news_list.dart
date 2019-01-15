import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';
import 'package:flutter_news/src/resources/repository.dart';
import 'package:flutter_news/src/widgets/news_list_tile.dart';
import 'package:flutter_news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  final Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: StreamBuilder(
        stream: bloc.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.hasData) {
            return _buildNewsList(snapshot.data, bloc);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildNewsList(List<int> topIds, StoriesBloc bloc) {
    return Refresh(
      child: ListView.builder(
        itemCount: topIds.length,
        itemBuilder: (BuildContext _, int index) {
          bloc.fetchItem(topIds[index]);

          return NewsListTile(
            topIds[index],
          );
        },
      ),
    );
  }
}
