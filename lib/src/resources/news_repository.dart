import 'dart:async';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

import 'package:flutter_news/src/models/item_model.dart';

class NewsRepository {
  List<NewsSource> sources = <NewsSource>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<NewsCache> caches = <NewsCache>[
    newsDbProvider,
  ];

  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() async {
    for (var source in sources) {
      List<int> ids = await source.fetchTopIds();
      if (ids != null) {
        return ids;
      }
    }

    // no caching for this
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    NewsSource source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if ((cache as NewsSource) != source) cache.addItem(item);
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class NewsSource {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class NewsCache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
