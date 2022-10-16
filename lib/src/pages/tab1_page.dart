import 'package:flutter/material.dart';
import 'package:noticias_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class Tab1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: ListaNoticias( headlines ),
    );
  }
}
