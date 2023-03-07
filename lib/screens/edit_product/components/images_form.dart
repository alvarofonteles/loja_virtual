// ignore: unused_import
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
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
      // corrigido para lista dinamica
      initialValue: List<dynamic>.from(product.images!),
      validator: (image) {
        if (image!.isEmpty) return 'Insira uma imagem';
        return null;
      },
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);

          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: <Widget>[
            AspectRatio(
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
                    color: primaryColor.withBlue(400),
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 50,
                      onPressed: () {
                        if (Platform.isAndroid) {
                          // padrão janela android
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        } else {
                          // padrão janela iOS
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        }
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
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
