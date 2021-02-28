import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews_topstories/models/article.dart';
import 'package:hackernews_topstories/services/article_details.dart';
import 'package:hackernews_topstories/services/locator.dart';
import 'package:url_launcher/url_launcher.dart';

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
                itemCount: articleList.length + 1,
                itemBuilder: (context, index) {
                  if (index == articleList.length) {
                    return CupertinoActivityIndicator();
                  }
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
                        title: Text(
                          articleList[index].title,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              DateTime.fromMicrosecondsSinceEpoch(
                                      articleList[index].time)
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              ' | ${articleList[index].by} | ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              '${articleList[index].type}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.launch),
                          onPressed: () async {
                            if (await canLaunch(articleList[index].url)) {
                              await launch(articleList[index].url);
                            }
                          },
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
