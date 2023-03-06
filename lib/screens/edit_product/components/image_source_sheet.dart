import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color colorDisabled = primaryColor.withAlpha(100);

    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // câmera
          ElevatedButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              backgroundColor: primaryColor,
              disabledBackgroundColor: colorDisabled,
            ),
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          // galeria
          ElevatedButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              backgroundColor: primaryColor,
              disabledBackgroundColor: colorDisabled,
            ),
            onPressed: () {},
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
