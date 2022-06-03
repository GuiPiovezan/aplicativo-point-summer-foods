import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerAdmin(
        indexNavigatorBar: indexNavigatorBar,
        pageController: _pageController,
      ),
      appBar: const CustomAppBarHome(
        title: "Administrativo",
      ),
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            indexNavigatorBar = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          OrderPage(
            status: "enviado",
          ),
          OrderPage(
            status: "aceito",
          ),
          OrderPage(
            status: "entregue",
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
              icon: Icon(Icons.new_label_outlined),
              label: "Novos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_outlined),
              label: "Aceitos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_outlined),
              label: "Entregues",
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
    );
  }
}
