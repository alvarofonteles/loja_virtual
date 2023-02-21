import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color colorPrimary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: colorPrimary,
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return Column(
            children: cartManager.items
                .map((cartProduct) => CartTile(cartProduct))
                .toList(),
          );
        },
      ),
    );
  }
}
