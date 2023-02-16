import 'package:firebase_auth/firebase_auth.dart' as user_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadingCurrentUser();
  }

  final user_auth.FirebaseAuth auth = user_auth.FirebaseAuth.instance;
  User? user;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  // logar/usuario
  Future<void> signIn(
      {required User user,
      required Function onFail,
      required Function onSucess}) async {
    loading = true;
    try {
      final user_auth.UserCredential result =
          await auth.signInWithEmailAndPassword(
              email: user.email!, password: user.password!);

      await _loadingCurrentUser(userCredential: result.user);

      // await Future.delayed(const Duration(seconds: 4));

      onSucess();
    } on user_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  // salvar/cadastrar/usuario
  Future<void> signUp(
      {required User user,
      required Function onFail,
      required Function onSucess}) async {
    try {
      final user_auth.UserCredential result =
          await auth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      user.id = result.user!.uid;
      this.user = user;

      // aguarda ser concluido (await)
      await user.saveData();

      onSucess();
    } on user_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadingCurrentUser({user_auth.User? userCredential}) async {
    user_auth.User currentUser = userCredential ?? auth.currentUser!;
    if (currentUser.toString().isNotEmpty) {
      final DocumentSnapshot docUser =
          await firestore.doc('users/${currentUser.uid}').get();
      user = User.fromDocument(docUser);

      // debugPrint('UID: ${user!.id}');
      // debugPrint('Nome: ${user!.name}');
      notifyListeners();
    }
  }
}
