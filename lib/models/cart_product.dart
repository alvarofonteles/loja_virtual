import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';

class CartProduct extends ChangeNotifier {
  // quantidade de produtos/item que vai ser adicionado
  CartProduct.fromProduct(this.product) {
    pid = product!.pid;
    quantity = 1;
    size = product!.selectedSize!.name;
  }

  // quantidade de produtos/item que está no firebase
  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;

    pid = document.get('pid');
    quantity = document.get('quantity');
    size = document.get('size');

    firestore
        .doc('products/$pid')
        .get()
        .then((doc) => product = Product.fromDocment(doc));
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // uid do card
  String? id;

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

  Map<String, dynamic> toCartItemsMap() {
    return {'pid': pid, 'quantity': quantity, 'size': size};
  }

  bool stackable(Product product) {
    return product.pid == pid && product.selectedSize!.name == size;
  }

  void increment() {
    quantity = quantity! + 1;
    notifyListeners();
  }

  void decrement() {
    quantity = quantity! - 1;
    notifyListeners();
  }
}
