import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

const _URL_NEWS = 'https://newsapi.org/v2';
const _API_KEY = '9ede9a80eee9441189a365acc1d1b8b0';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'),
    Category( FontAwesomeIcons.tv, 'entertainment'),
    Category( FontAwesomeIcons.addressCard, 'general'),
    Category( FontAwesomeIcons.headSideVirus, 'health'),
    Category( FontAwesomeIcons.vials, 'science'),
    Category( FontAwesomeIcons.volleyball, 'sports'),
    Category( FontAwesomeIcons.memory, 'technology'),
  ];

  //Crear un mapa que apunte a un listado de las categorías
  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    getTopHeadlines();
    
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }

    getArticlesByCategory(_selectedCategory);
  }

  get selectecCategory => _selectedCategory;

  set selectecCategory( dynamic valor ){
    _selectedCategory = valor;
    
    getArticlesByCategory( valor );
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada => categoryArticles[selectecCategory];

  getTopHeadlines() async {

    /*
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'CO', 'apiKey': _API_KEY});
    final resp = await http.get(uri);
     */

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=CO');
    final resp = await http.get(url);

    final newResponse = newsResponseFromJson( resp.body );

    headlines.addAll( newResponse.articles );
    notifyListeners();
  }

  getArticlesByCategory( String category ) async {

    if(categoryArticles[category]!.isNotEmpty ){
      return categoryArticles[category];
    }

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=CO&category=$category');
    final resp = await http.get(url);

    final newResponse = newsResponseFromJson( resp.body );

    categoryArticles[category]!.addAll(newResponse.articles);

    notifyListeners();
  }

}