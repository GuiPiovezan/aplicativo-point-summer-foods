import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class ProductAdministrationPage extends StatefulWidget {
  const ProductAdministrationPage({Key? key}) : super(key: key);

  @override
  State<ProductAdministrationPage> createState() => _ProductAdministrationPageState();
}

class _ProductAdministrationPageState extends State<ProductAdministrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      drawer: const CustomDrawerAdmin(),
      appBar: const CustomAppBarHome(
        icon: Icon(
          Icons.screen_search_desktop_sharp,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        title: " Cardapio",
      ),
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            indexNavigatorBar = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          ProductPage(
            category: "Açai",
          ),
          ProductPage(
            category: "Salgados",
          ),
          ProductPage(
            category: "Porções",
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 74, 44, 82),
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(500, 50),
            topRight: Radius.elliptical(500, 50),
          ),
        ),
        child: BottomNavigationBar(
          onTap: (int page) {
            setState(() {
              indexNavigatorBar = page;
            });
            _pageController.jumpToPage(
              page,
            );
          },
          currentIndex: indexNavigatorBar,
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          fixedColor: Colors.green,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.icecream_outlined),
              label: "Açaí",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              label: "Salgado",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_rounded),
              label: "Porçoes",
            ),
          ],
        ),
      ),
    );
  }
}
