import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Color colorPrimary = Theme.of(context).primaryColor;

    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        // não mover ao arrastar para o lado
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          // const LoginSreen(),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: colorPrimary,
              title: const Text('Home'),
            ),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: colorPrimary,
              title: const Text('Produtos'),
            ),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: colorPrimary,
              title: const Text('Meus Pedidos'),
            ),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: colorPrimary,
              title: const Text('Lojas'),
            ),
          ),
        ],
      ),
    );
  }
}
