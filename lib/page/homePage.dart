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
              child: isLoading
                  ? CircularProgressIndicator()
                  : ListView.builder(itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: ListTile(
                          tileColor: Colors.orange.shade100,
                          leading: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                _news?.articles[index].urlToImage ?? 'hello',
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              )),
                          title: Text(
                            _news!.articles[index].title,
                            maxLines: 3,
                          ),
                          subtitle: Text('Source: ${_news!.articles[index].source.name}'),
                        ),
                      );
                    }))
          // Text('${_news?.totalResults.toString()}'),
          ),
    );
  }
}
