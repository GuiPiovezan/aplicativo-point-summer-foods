import 'package:flutter/material.dart';
import 'package:pointsf/Services/AuthService/auth-service.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Icon? icon;

  const CustomAppBarHome({
    Key? key,
    this.title,
    this.icon,
  }) : super(key: key);

  void _logOut(context) {
    AuthService().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          );
        },
      ),
      title: Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: icon ?? Container(),
            ),
            Text(
              title ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
          child: TextButton(
            child: const Text(
              "sair",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onPressed: () => _logOut(context),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
      centerTitle: true,
      shadowColor: const Color.fromARGB(0, 255, 255, 255),
    );
  }

  @override
  // TODO: implement preferredSizeheight
  Size get preferredSize => const Size.fromHeight(80);
}
