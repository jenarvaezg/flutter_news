import 'dart:convert' show json;
import 'package:flutter_news/src/resources/news_repository.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_news/src/models/item_model.dart';

const _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements NewsSource {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseUrl/topstories.json');

    return new List<int>.from(json.decode(response.body));
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_baseUrl/item/$id.json');

    return ItemModel.fromJson(
      json.decode(response.body),
    );
  }
}