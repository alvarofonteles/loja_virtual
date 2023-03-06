import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  void updateUser(UserManager userManager) {
    if (userManager.adminEnabled) _listenToUsers();
  }

  Future<void> _listenToUsers() async {
    final faker = Faker();

    for (var i = 0; i < 200; i++) {
      users.add(User(
        name: faker.person.name(),
        email: faker.internet.email(),
      ));
    }

    // lista em ordem alfabética por nome
    users
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

    notifyListeners();
  }

  List<String> get names => users.map((e) => e.name!).toList();
}
