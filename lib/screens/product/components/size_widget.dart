import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({this.size, super.key});

  final ItemSize? size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;
    bool hasStock = size!.hasStock;

    final Color colorPrimary = Theme.of(context).primaryColor;
    Color color;
    if (!hasStock) {
      color = Colors.red.withAlpha(50);
    } else if (selected) {
      color = colorPrimary;
    } else {
      color = Colors.grey.shade600;
    }

    return GestureDetector(
      onTap: () => hasStock ? product.selectedSize = size : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size!.name!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size!.price!.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
