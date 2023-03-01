import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color colorPrimary = Theme.of(context).primaryColor;

    void searchDialog(
        ProductManager productManager, BuildContext context) async {
      final search = showDialog(
        context: context,
        builder: (_) => SearchDialog(productManager.search),
      );

      if (search.toString().trim().isNotEmpty) {
        productManager.search = await search;
      }
    }

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            return LayoutBuilder(
              builder: (_, constraints) {
                if (productManager.search == null ||
                    productManager.search!.isEmpty) {
                  return const Text('Produtos');
                } else {
                  return GestureDetector(
                    child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      searchDialog(productManager, context);
                    },
                  );
                }
              },
            );
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search == null ||
                  productManager.search!.isEmpty) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchDialog(productManager, context);
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    productManager.search = '';
                  },
                );
              }
            },
          ),
        ],
      ),
      // '.builder' = constroi a medida que vai rolando a tela
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(7),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filteredProducts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: colorPrimary,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
