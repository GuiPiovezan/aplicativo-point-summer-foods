import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? enableIconBack;

  const CustomAppBar({
    Key? key,
    this.title,
    this.enableIconBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          backgroundColor: const Color.fromARGB(0, 254, 220, 86),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 74, 44, 82),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          title: Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              title ?? "",
              style: const TextStyle(
                color: Color.fromARGB(255, 240, 240, 240),
              ),
            ),
          ),
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Image.asset(
                'assets/images/logo-escrita.png',
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          leading: enableIconBack == true
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 83, 5, 64),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      textDirection: TextDirection.rtl,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              : Container(),
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
  Size get preferredSize => const Size.fromHeight(87);
}
