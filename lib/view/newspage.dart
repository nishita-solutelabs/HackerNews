import 'package:flutter/material.dart';
import 'package:hackernews_topstories/models/article.dart';
import 'package:hackernews_topstories/services/article_details.dart';
import 'package:hackernews_topstories/services/locator.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> articleList = List<Article>();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async {
    articleList = await locator.get<ArticleDetails>().load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News Top Stories'),
      ),
      body: Container(
        color: Colors.teal,
        child: articleList != null && articleList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                itemCount: articleList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(articleList[index].title),
                        subtitle: Row(
                          children: [
                            Text('${articleList[index].time} | '),
                            Text('${articleList[index].by} | '),
                            Text('${articleList[index].type}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
