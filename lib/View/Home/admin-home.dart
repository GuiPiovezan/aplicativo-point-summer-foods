import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerAdmin(),
      appBar: const CustomAppBarHome(
        title: "Administrativo",
      ),
      body: Container()
    );
  }
}
