import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_product.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {super.key});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    final Color colorPrimary = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product!.images!.first),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartProduct.product!.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Tamanho: ${cartProduct.size}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      // fui eu quem criou :D
                      // 'R\$ ${cartProduct.product.selectedSize!.price!.toStringAsFixed(2)}',
                      // 'R\$ ${cartProduct.itemSize!.price!.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
