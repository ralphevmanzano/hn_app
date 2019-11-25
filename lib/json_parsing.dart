import 'package:hn_app/src/article.dart';
import 'dart:convert';

List<int> parseTopStories(String json) {
  final parsed = jsonDecode(json);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String json) {
  throw UnimplementedError();
}