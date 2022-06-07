import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/config_model.dart';

class ConfigException implements Exception {
  String message;
  ConfigException(this.message);
}

class ConfigService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  setConfig(ConfigModel model, BuildContext context) {
    try {
      firestore.collection('config').doc("settings").set({
        "deliveryFee": model.deliveryFee,
        "deliveryTime": model.deliveryTime,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  updateDeliveryFee(String deliveryFee) {
    try {
      firestore.collection('config').doc("settings").update({
        "deliveryFee": deliveryFee,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  updateDeliveryTime(String updateDeliveryTime) {
    try {
      firestore.collection('config').doc("settings").update({
        "deliveryTime": updateDeliveryTime,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  getConfig() {
    return firestore.collection('config').snapshots();
  }
}
