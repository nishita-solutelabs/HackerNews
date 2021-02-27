import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Network {
  Future<List<int>> getTopStoryIds() async {
    final List<int> idList = <int>[];

    Dio dio = Dio();
    try {
      final Response<List<dynamic>> response = await dio.get(
          'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

      if (response.statusCode == 200) {
        for (final dynamic id in response.data) {
          idList.add(id);
        }
      } else {
        throw Exception('Unable to connect');
      }
    } catch (e) {
      debugPrint(e);
    }
    return idList;
  }
}
