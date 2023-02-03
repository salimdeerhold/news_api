import 'package:dio/dio.dart';
import 'model/News.dart';

class Service {
  static const URL =
      "https://newsapi.org/v2/everything?q=bitcoin&apiKey=3bc50fb899384d0aa37b8428f885f94e";

  static Future<News> getNews() async {
    var dio = Dio();
    try {
      final response = await dio.get(URL);
      if (200 == response.statusCode) {
        var data = response.data;
        News objects = News.fromJson(data);
        return objects;
      } else {
        return Future.error("Failed to get data");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
