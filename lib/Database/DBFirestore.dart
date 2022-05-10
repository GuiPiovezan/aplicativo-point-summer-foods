import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBFirestore{

  DBFirestore._(); // Privando o construtor da classe
  static final DBFirestore instancia = DBFirestore._();
  final FirebaseFirestore firestore  = FirebaseFirestore.instance; //instaciando o firestore
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  static FirebaseFirestore get(){
    return DBFirestore.instancia.firestore; // Função para chamar a instancia do Firestore.
  }

  static FirebaseAuth autenticar(){
    return DBFirestore.instancia.auth;
  }

}