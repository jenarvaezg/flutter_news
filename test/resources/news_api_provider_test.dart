import 'dart:convert';
import 'dart:io' show HttpStatus;

import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:flutter_news/src/resources/news_api_provider.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      return Response(
        json.encode([1, 2, 3, 4]),
        HttpStatus.ok,
      );
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem returns an item', () async {
    final id = 1;
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      if (request.url.toString().split('/').last == '$id.json') {
        return Response(
          json.encode({'id': id, 'title': 'test'}),
          HttpStatus.ok,
        );
      }

      return Response(
        null,
        HttpStatus.ok, //hackernews returns 200 instead of 404  when id is not found 🤷
      );
    });

    final item = await newsApi.fetchItem(id);
    expect(item.id, id);
  });
}
