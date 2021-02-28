import 'package:flutter/material.dart';
import 'package:hackernews_topstories/models/article.dart';
import 'package:hackernews_topstories/services/locator.dart';
import 'package:hackernews_topstories/services/networking.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class ArticleDetails {
  List<Article> articleList = List<Article>();
  Future<List<Article>> load() async {
    List<int> idList = await locator.get<Network>().getTopStoryIds();
    for (int i = 0; i < 10; i++) {
      await getArticleById(idList[i], articleList);
    }
    return articleList;
  }

  Future<List<Article>> loadMore(int loadTimes) async {
    List<Article> list = List<Article>();
    List<int> idList = await locator.get<Network>().getTopStoryIds();
    for (int i = loadTimes * 10; i < ((loadTimes * 10) + 10); i++) {
      await getArticleById(idList[i], list);
    }
    print(list.length);
    return list;
  }

  Future getArticleById(int id, List<Article> list) async {
    Dio dio = Dio();
    Response<dynamic> response = await dio.get(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
    if (response.statusCode == 200) {
      final body = response.data;
      Article article = Article.fromMap(body);
      list.add(article);
    } else {
      debugPrint(response.statusMessage.toString());
    }
  }
}
