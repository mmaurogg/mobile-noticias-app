import 'package:flutter/material.dart';
import 'package:noticias_app/src/pages/tab1_page.dart';
import 'package:noticias_app/src/services/services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: Paginas(),
            bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'pa ti'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
        ]);
  }
}

class Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget> [
        Tab1Page(),

        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}


class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual( int valor ) {
    _paginaActual = valor;

    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);

    notifyListeners();
  }

  PageController get pageController => _pageController;

}