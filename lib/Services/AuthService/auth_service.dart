import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/customer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pointsf/View/export_all_view.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? user;
  String? userName = "Loading";
  String? userPhone = "Loading";
  String? userRoute = "";

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
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

  setUserPhone() {
    if (userPhone != "Loading") return null;
    firestore
        .collection("usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      userPhone =
          event['telefone'] != null ? event['telefone'].toString() : "erro";
    });
  }

  getUid() {
    return _auth.currentUser!.uid;
  }

  getUserEmail() {
    return _auth.currentUser!.email;
  }

  getUserName() {
    return userName;
  }

  getUserPhone() {
    return userPhone;
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
      "admin": model.admin,
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
      await _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }

    bool admin = false;
    await firestore
        .collection("usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      admin = event['admin'] ?? false;
    });

    if (admin) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AdminHome()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Home()),
        (route) => false,
      );
    }
  }

  setRoute() async {
    bool admin = false;
    await firestore
        .collection("usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      admin = event['admin'] ?? false;
    });
    admin != true ? userRoute = '/home' : userRoute = '/adminHome';
  }

  getRoute() {
    return userRoute;
  }

  logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  updateUser(CustomerModel model, BuildContext context) {}
}
