import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/admin/admin_users_screen.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            // não mover ao arrastar para o lado
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const HomeScreen(),
              const ProductsScreen(),
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Meus Pedidos'),
                ),
              ),
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),
              // '... []' - adiciona novas listas
              if (userManager.adminEnabled) ...[
                const AdminUsersScreen(),
                Scaffold(
                  drawer: const CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
