import 'package:loja_virtual/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    pid = product.pid;
    quantity = 1;
    size = product.selectedSize!.name;
  }

  String? pid;
  int? quantity;
  String? size;

  Product product;
}
