import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/News.dart';
import '../service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  News? _news;

  @override
  void initState() {
    super.initState();
    Service.getNews().then((news) {
      setState(() {
        _news = news;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text('News'),
            actions: [
              Center(child: Text('Total: ${_news?.totalResults.toString()}')),
            ],
          ),
          body: Container(
              width: double.infinity,
              height: double.infinity,
              child: isLoading
                  ? CircularProgressIndicator()
                  : ListView.builder(itemBuilder: (context, index) {
                      return Container(
                        color: Colors.orange.shade100,
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                _news!.articles[index].urlToImage ??
                                  "https://images.unsplash.com/photo-1526470608268-f674ce90ebd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    _news!.articles[index].title,
                                    // softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    // maxLines: 2,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Text(
                                  "Source: ${_news!.articles[index].source.name}",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }))
          // Text('${_news?.totalResults.toString()}'),
          ),
    );
  }
}
