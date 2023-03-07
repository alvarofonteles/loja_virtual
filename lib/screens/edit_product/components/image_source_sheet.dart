import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelected, super.key});

  // callback
  final Function(File)? onImageSelected;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    // Plataforma android
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // câmera
            ElevatedButton(
              autofocus: true,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: primaryColor,
              ),
              onPressed: () async {
                final XFile? file =
                    await _picker.pickImage(source: ImageSource.camera);
                onImageSelected!(File(file!.path));
              },
              child: const Text('Câmera'),
            ),
            // galeria
            ElevatedButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                backgroundColor: primaryColor,
              ),
              onPressed: () async {
                final XFile? file =
                    await _picker.pickImage(source: ImageSource.gallery);
                onImageSelected!(File(file!.path));
              },
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      // plataforma iOS
      return CupertinoActionSheet(
        title: const Text('Selecione uma Imagem'),
        message: const Text('Escolha o Local'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }
}
