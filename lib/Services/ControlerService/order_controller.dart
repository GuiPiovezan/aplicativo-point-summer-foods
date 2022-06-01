import 'package:flutter/material.dart';

class OrderControllerException implements Exception {
  String message;
  OrderControllerException(this.message);
}

class OrderControllerService extends TextEditingController {
  TextEditingController? money;
}
