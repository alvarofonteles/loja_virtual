import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            return LayoutBuilder(
              builder: (_, constraints) {
                return productManager.search.isEmpty
                    ? const Text('Produtos')
                    : GestureDetector(
                        child: SizedBox(
                          width: constraints.biggest.width,
                          child: Text(
                            productManager.search,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () async {
                          searchShowDialog(productManager, context);
                        },
                      );
              },
            );
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              return productManager.search.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        searchShowDialog(productManager, context);
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        productManager.search = '';
                      },
                    );
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
              return ProductListTile(product: filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}

void searchShowDialog(
    ProductManager productManager, BuildContext context) async {
  final search = showDialog(
    context: context,
    builder: (_) => SearchDialog(initialText: productManager.search),
  );
  if (search.toString().trim().isNotEmpty) {
    productManager.search = await search;
  }
}
