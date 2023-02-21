import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/product.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Color colorPrimary = Theme.of(context).primaryColor;
    final Color colorDisabled = Colors.grey.shade600;
    //Theme.of(context).primaryColor.withAlpha(100);

    // '.value' - passa o produto que já existe
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          title: Text(product.name!),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images:
                    product.images!.map((url) => NetworkImage(url)).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: colorPrimary,
                // passa sozinho - true
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.minPrice}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorPrimary,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    // largura
                    spacing: 8,
                    // altura
                    runSpacing: 8,
                    children:
                        product.sizes!.map((s) => SizeWidget(size: s)).toList(),
                  ),
                  const SizedBox(height: 7),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedSize != null
                                ? () {
                                    userManager.isLoggedIn
                                        ? context
                                            .read<CartManager>()
                                            .addToCart(product)
                                        : Navigator.of(context)
                                            .pushNamed('/login');
                                  }
                                : null,
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              backgroundColor: colorPrimary,
                              disabledBackgroundColor: colorDisabled,
                            ),
                            child: userManager.loading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text(userManager.isLoggedIn
                                    ? 'Adicionar ao Carrinho'
                                    : 'Entre para Comprar'),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
