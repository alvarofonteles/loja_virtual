// ignore: unused_import
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color colorDisabled = Theme.of(context).primaryColor.withAlpha(100);

    return FormField<List>(
      initialValue: product.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value!.map((image) {
              return Stack(
                // 'fit' substitue o alignment, junto com o BoxFit
                fit: StackFit.expand,
                children: [
                  if (image is String)
                    Image.network(
                      image,
                      // ocupa todo espaço necessário
                      fit: BoxFit.cover,
                    )
                  else
                    // TODO: cast File
                    // Image.file(image as File),
                    Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        state.value!.remove(image);
                        // avisa da mundaça no form, assim refaz o state
                        state.didChange(state.value);
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                  ),
                ],
              );
            }).toList(),
            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
            // passa sozinho - true
            autoplay: false,
          ),
        );
      },
    );
  }
}
