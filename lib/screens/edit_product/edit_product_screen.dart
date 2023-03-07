import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product, {super.key});

  final Product product;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            ElevatedButton(
              style: TextButton.styleFrom(
                //padding: const EdgeInsets.symmetric(horizontal: 80),
                textStyle: const TextStyle(
                  //color: Colors.grey.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: primaryColor,
              ),
              onPressed: () {
                if (formkey.currentState!.validate()) {
                } else {}
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
