import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    pid = product!.pid;
    quantity = 1;
    size = product!.selectedSize!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    pid = document.get('pid');
    quantity = document.get('quantity');
    size = document.get('size');

    firestore
        .doc('products/$pid')
        .get()
        .then((doc) => product = Product.fromDocment(doc));
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? pid;
  int? quantity;
  String? size;

  Product? product;

  ItemSize? get itemSize {
    if (product == null) return null;
    return product!.findSize(size!)!;
  }

  num get unitPrice {
    if (product.toString().isEmpty) return 0;
    return itemSize!.price ?? 0;
  }
}
