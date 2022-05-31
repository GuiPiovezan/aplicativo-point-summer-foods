import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class ProductAdministration extends StatefulWidget {
  const ProductAdministration({Key? key}) : super(key: key);

  @override
  State<ProductAdministration> createState() => _ProductAdministrationState();
}

class _ProductAdministrationState extends State<ProductAdministration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      drawer: const CustomDrawerAdmin(),
      appBar: const CustomAppBar(
        title: "Produtos",
      ),
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            indexNavigatorBar = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          ProductAdministrationPage(
            category: "Açai",
          ),
          ProductAdministrationPage(
            category: "Salgado",
          ),
          ProductAdministrationPage(
            category: "Bebida",
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
              label: "Salgados",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_rounded),
              label: "Bebidas",
            ),
          ],
        ),
      ),
    );
  }
}
