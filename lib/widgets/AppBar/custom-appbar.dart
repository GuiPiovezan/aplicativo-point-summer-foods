import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? iconBack;

  const CustomAppBar({
    Key? key,
    this.title,
    this.iconBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      title: Text(
        title ?? "",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 10, 0),
          child: Image.asset(
            'images/logo-escrita.png',
          ),
        ),
      ],
      automaticallyImplyLeading: false,
      leading: iconBack == true
          ? Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 83, 5, 64),
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
              margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: IconButton(
                icon: Icon(
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
      shadowColor: Color.fromARGB(0, 255, 255, 255),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSizeheight
  Size get preferredSize => Size.fromHeight(80);
}
