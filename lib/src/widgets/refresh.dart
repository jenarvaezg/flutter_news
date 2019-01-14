import 'package:flutter/material.dart';
import 'package:flutter_news/src/blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    StoriesBloc bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
        // bloc.fetchTopIds();
      },
    );
  }
}
