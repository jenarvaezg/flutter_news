import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/comments_provider.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';
import 'package:flutter_news/src/screens/news_list.dart';
import 'package:flutter_news/src/screens/news_detail.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
          home: NewsList(),
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    }

    return MaterialPageRoute(
      builder: (BuildContext context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.split('/')[1]);

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetail(itemId);
      },
    );
  }
}
