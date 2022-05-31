import 'package:flutter/material.dart';

class ControllerCustomerException implements Exception {
  String message;
  ControllerCustomerException(this.message);
}

class CustomerControllerService extends TextEditingController {
  String? page;
  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? cellphone;
  TextEditingController? cpf;
  TextEditingController? password;
  TextEditingController? confirmPassword;

  CustomerControllerService() {
    _CustomerControllerService();
  }

  _CustomerControllerService() {
    name = TextEditingController();
    email = TextEditingController();
    cellphone = TextEditingController();
    cpf = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }
}
