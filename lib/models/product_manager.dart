import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductManager {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    for (DocumentSnapshot doc in snapProducts.docs) {
      // mostar toda lista '${doc.data}'
      debugPrint('Produtos: ${doc.data}');
    }
  }
}
