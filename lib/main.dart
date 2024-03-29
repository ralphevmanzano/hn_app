import 'package:flutter/material.dart';
import 'package:hn_app/src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await new Future.delayed(Duration(seconds: 1));
            setState(() {
              _articles.removeAt(0);
            });
          },
          child: ListView(
            children: _articles.map((article) => _buildItem(article)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.text),
      padding: const EdgeInsets.only(top: 16.0),
      child: ExpansionTile(
        title: Text(
          article.text,
          style: TextStyle(fontSize: 24.0),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${article.commentsCount} comments"),
                IconButton(
                  icon: Icon(Icons.launch),
                  onPressed: () async {
                    final fakeUrl = "http://${article.domain}";
                    if (await canLaunch(fakeUrl)) {
                      launch(fakeUrl);
                    } else {
                      throw "Could not launch";
                    }
                  },
                )
              ],
            ),
          )
        ],
        /*contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
        subtitle: Text("${article.commentsCount} comments"),
        onTap: () async {
          final fakeUrl = "http://${article.domain}";
          if (await canLaunch(fakeUrl)) {
            launch(fakeUrl);
          } else {
            throw "Could not launch";
          }
        },*/
      ),
    );
  }
}
