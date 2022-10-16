import 'package:flutter/material.dart';
import 'package:noticias_app/src/models/models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _API_KEY = '9ede9a80eee9441189a365acc1d1b8b0';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  NewsService(){

    getTopHeadlines();

  }

  getTopHeadlines() async {

    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'CO', 'apiKey': _API_KEY});
    final resp = await http.get(uri);

    //final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=CO');
    //final resp = await http.get(url);

    final newResponse = newsResponseFromJson( resp.body );

    headlines.addAll( newResponse.articles );
    notifyListeners();
  }

}