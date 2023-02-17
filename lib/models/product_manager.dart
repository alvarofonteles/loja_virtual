import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product>? allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    allProducts =
        snapProducts.docs.map((e) => Product.fromDocment(e)).toList();

    notifyListeners();

    // anotherExamples(firestore);
  }
}




/*
// mais exemplos
void anotherExamples(FirebaseFirestore firestore) {
  // altera
  firestore.doc('products/Rp7dh3jKEW7M2sd9SZBw').update({
    'description': 'Camiseta de alta qualidade!!!',
    'name': 'Camiseta Branca',
  });

  // lista valores do produto
  firestore.collection('products').snapshots().listen((snapshot) {
    for (DocumentSnapshot snapProducts in snapshot.docs) {
      debugPrint(snapProducts.data.toString());
      debugPrint(snapProducts.get('name'));
      debugPrint(snapProducts.get('description'));
    }
  });
}
*/