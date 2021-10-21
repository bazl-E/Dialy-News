import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<List<News>> fetchNews() async {
  try {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=e5f9087b04fa4ae38b8d8d8a5f998df2#';
    final data = await http.get(Uri.parse(url));

    final newsData = jsonDecode(data.body);

    final List<dynamic> newsList = newsData['articles'];

    for (var news in newsList) {
      if (newses
          .where((element) => element.title == news['title'])
          .toList()
          .isEmpty) {
        newses.add(
          News(
            id: news['source']['id'] ?? '',
            author: news['author'] ?? '',
            title: news['title'] ?? '',
            date: news['publishedAt'] ?? '',
            descrption: news['description'] ?? '',
            content: news['content'] ?? '',
            image: news['urlToImage'] ?? '',
            moreLink: news['url'] ?? '',
          ),
        );
      }
    }
    return newses;
  } on Error catch (_) {
    print('error1');
    throw Error();
  } on Exception catch (_) {
    print('error2');
    throw Exception();
  }
}

List<News> newses = [];

News getNews(String title) {
  return newses.firstWhere((element) => element.title == title);
}

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

class News {
  News({
    required this.id,
    required this.author,
    required this.title,
    required this.date,
    required this.descrption,
    required this.content,
    required this.image,
    required this.moreLink,
  });
  final String id;
  final String author;
  final String title;
  final String date;
  final String descrption;
  final String content;
  final String image;
  final String moreLink;
}
