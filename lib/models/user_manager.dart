import 'package:firebase_auth/firebase_auth.dart' as user_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager extends ChangeNotifier {
  final user_auth.FirebaseAuth auth = user_auth.FirebaseAuth.instance;

  UserManager() {
    if (auth.currentUser != null) _loadingCurrentUser();
  }

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
      // recupera os dados do usuario na autenticação
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
    loading = true;
    try {
      // salva na autenticação os usuarios
      final user_auth.UserCredential result =
          await auth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      user.id = result.user!.uid;
      this.user = user;

      // aguarda ser concluido (await)
      // salva os dados do usuario no firestore
      await user.saveData();

      onSucess();
    } on user_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
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

      final docAdmin = await firestore.collection('admins').doc(user!.id).get();
      if (docAdmin.exists) user!.admin = true;

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user!.admin;
}
