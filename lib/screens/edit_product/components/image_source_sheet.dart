import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelected, super.key});

  // callback
  final Function(File)? onImageSelected;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    Future<void> editImage(String path) async {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editar Imagem',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Editar Imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir',
          )
        ],
      );

      if (croppedFile != null) onImageSelected!(File(croppedFile.path));
    }

    // Plataforma android
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // câmera
            ElevatedButton(
              autofocus: true,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: primaryColor,
              ),
              onPressed: () async {
                final XFile? file =
                    await _picker.pickImage(source: ImageSource.camera);

                editImage(file!.path);
              },
              child: const Text('Câmera'),
            ),
            // galeria
            ElevatedButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                backgroundColor: primaryColor,
              ),
              onPressed: () async {
                final XFile? file =
                    await _picker.pickImage(source: ImageSource.gallery);

                editImage(file!.path);
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
          // câmera iOS
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final XFile? file =
                  await _picker.pickImage(source: ImageSource.camera);

              editImage(file!.path);
            },
            child: const Text('Câmera'),
          ),
          // galeria iOS
          CupertinoActionSheetAction(
            onPressed: () async {
              final XFile? file =
                  await _picker.pickImage(source: ImageSource.gallery);

              editImage(file!.path);
            },
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
