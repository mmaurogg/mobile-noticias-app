import 'package:flutter/material.dart';
import 'package:noticias_app/src/models/category_model.dart';
import 'package:noticias_app/src/services/news_service.dart';
import 'package:noticias_app/src/theme/tema.dart';
import 'package:noticias_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tap2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget> [
            
            _ListaCategorias(),

            Expanded(child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada!))
            
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {

            final cName = categories[index].name;

            return Container(
              width: 110,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    _CategoryButtom(categories[index]),
                    const SizedBox( height: 5 ),
                    Text('${ cName[0].toUpperCase() }${cName.substring(1)}')
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}

class _CategoryButtom extends StatelessWidget {

  final Category categoria;

  const _CategoryButtom( this.categoria );

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //print(categoria.name);
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectecCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape:  BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectecCategory == categoria.name )
          ? miTema.primaryColor
          :  Colors.black54,
        ),
      ),
    );

  }
}
