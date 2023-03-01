import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withBlue(500),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true, floating: true,
                // remove possível sombra
                // elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja de Bazar da Lorena'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                  ),
                ],
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 2000,
                  width: 200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
