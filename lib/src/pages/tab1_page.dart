import 'package:flutter/material.dart';
import 'package:noticias_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class Tab1Page extends StatefulWidget {

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: (headlines.isEmpty)
      ? const Center(
        child: CircularProgressIndicator())
      : ListaNoticias( headlines ),
    );
  }

  // esto mantiene el estado del witget
  @override
  bool get wantKeepAlive => true;
}
