import 'package:firebase_auth/firebase_auth.dart' as user_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/user.dart' as users;

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadingCurrentUser();
  }

  final user_auth.FirebaseAuth auth = user_auth.FirebaseAuth.instance;
  late user_auth.User userAuth;

  bool _loading = false;
  bool get loading => _loading;

  // logar/usuario
  Future<void> signIn(
      {required users.User users,
      required Function onFail,
      required Function onSucess}) async {
    loading = true;
    try {
      final user_auth.UserCredential result =
          await auth.signInWithEmailAndPassword(
              email: users.email!, password: users.password!);

      userAuth = result.user!;

      // await Future.delayed(const Duration(seconds: 4));

      onSucess();
    } on user_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  // salvar/cadastrar/usuario
  Future<void> signUp(
      {required users.User users,
      required Function onFail,
      required Function onSucess}) async {
    try {
      final user_auth.UserCredential result =
          await auth.createUserWithEmailAndPassword(
              email: users.email!, password: users.password!);

      userAuth = result.user!;

      onSucess();
    } on user_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadingCurrentUser() async {
    final user_auth.User currentUser = auth.currentUser!;
    if (currentUser.toString().isNotEmpty) {
      userAuth = currentUser;
      debugPrint('Usuario UID: ${userAuth.uid}');
    }
    notifyListeners();
  }
}
