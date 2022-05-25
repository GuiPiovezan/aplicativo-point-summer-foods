import 'package:flutter/material.dart';

import 'package:pointsf/View/Cart/cart.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      drawer: const CustomDrawer(),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 44, 82),
        child: const Icon(
          Icons.shopping_cart,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const Cart()),
            ),
          );
        },
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
          onTap: (int index) {
            setState(() {
              indexNavigatorBar = index;
            });
            _pageController.jumpToPage(
              index,
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
