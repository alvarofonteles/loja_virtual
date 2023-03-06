import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  Future<void> _listenToUsers() async {
    // atualiza em tempo real, mas não há necessidade
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((d) => User.fromDocument(d)).toList();
      // lista em ordem alfabética por nome
      users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });

    /*// usuários fakes para testes
    final faker = Faker();
    for (var i = 0; i < 200; i++) {
      users.add(User(
        name: faker.person.name(),
        email: faker.internet.email(),
      ));
    }*/

    // não atualiza em tempo real a adição de um novo usuário
    /*firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((d) => User.fromDocument(d)).toList();
      // lista em ordem alfabética por nome
      users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
    
    // lista em ordem alfabética por nome
    users
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

    notifyListeners();*/
  }

  List<String> get names => users.map((e) => e.name!).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
