import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/customer-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pointsf/View/export-all-view.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? user;
  bool isLoading = true;
  String? userName = "Loading";

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  setUserName() {
    if (userName != "Loading") return null;
    firestore
        .collection("usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      userName = event['nome'] != null ? event['nome'].toString() : "erro";
    });
  }

  getUid() {
    return _auth.currentUser!.uid;
  }

  getUser() {
    return _auth.currentUser;
  }

  getUserEmail() {
    return _auth.currentUser!.email;
  }

  getUserName() {
    return userName;
  }

  register(String email, String senha, CustomerModel model,
      BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
    firestore.collection('usuarios').doc(user!.uid).set({
      "nome": model.nome,
      "uid": user!.uid,
      "telefone": model.telefone,
      "cpf": model.cpf,
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  login(String email, String senha, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => Home()),
      (route) => false,
    );
  }

  logout(BuildContext context) async {
    await _auth.signOut();
    _getUser();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Welcome(),
      ),
    );
  }
}
