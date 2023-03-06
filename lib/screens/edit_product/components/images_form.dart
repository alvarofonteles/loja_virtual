// ignore: unused_import
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/edit_product/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return FormField<List>(
      initialValue: product.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value!.map<Widget>((image) {
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
                      color: primaryColor,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                  ),
                ],
              );
            }).toList()
              ..add(Material(
                color: primaryColor.withBlue(500),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 50,
                  onPressed: () {
                    // padrão janela android
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const ImageSourceSheet(),
                    );
                    // padrão janela iOS
                  },
                  icon: const Icon(Icons.add_a_photo),
                ),
              )),
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
