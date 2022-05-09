import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String textoBotao;

  ButtonPrimary(this.textoBotao);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.all(8.0),
    //   child: ElevatedButton(
    //     style: ButtonStyle(
    //       fixedSize: MaterialStateProperty.all(const Size(100, 50)),
    //       textStyle: MaterialStateProperty.all(
    //         const TextStyle(fontSize: 24),
    //       ),
    //     ),
    //     onPressed: () {},
    //     child: Text(textoBotao),
    //   ),
    // );
    return Center(
      child: Container(
        height: 52,
        width: 267,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            textoBotao,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(15),
            backgroundColor: Color.fromARGB(255, 83, 5, 64),
            side: BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
