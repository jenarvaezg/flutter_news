import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';
import 'package:flutter_news/src/screens/news_list.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
      title: 'News!',
      home: NewsList(),
    ));
  }
}
