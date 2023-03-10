import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  // pesquisa produtos
  String? _search;

  String? get search => _search;
  set search(String? value) {
    _search = value;
    notifyListeners();
  }

  // filtra os produtos
  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search == null || search!.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where(
          (p) => p.name!.toLowerCase().contains(search!.toLowerCase()),
        ),
      );
    }
    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    allProducts = snapProducts.docs.map((e) => Product.fromDocment(e)).toList();

    notifyListeners();
  }

  Product? findProductById(String pid) {
    try {
      return allProducts.firstWhere((p) => p.pid == pid);
    } catch (e) {
      return null;
    }
  }
}
