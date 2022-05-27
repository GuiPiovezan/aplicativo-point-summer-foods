import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';

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
    return PreferredSize(
      child: Container(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 74, 44, 82),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 240, 240, 240),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                    color: Color.fromARGB(255, 240, 240, 240),
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
                  "Sair",
                  style: TextStyle(
                    color: Color.fromARGB(255, 240, 240, 240),
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
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 74, 44, 82),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(500, 70),
            bottomRight: Radius.elliptical(500, 70),
          ),
        ),
      ),
      preferredSize: const Size.fromHeight(80),
    );
  }

  @override
  // TODO: implement preferredSizeheight
  Size get preferredSize => const Size.fromHeight(87);
}
