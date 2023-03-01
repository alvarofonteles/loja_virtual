import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog(this.initialText, {super.key});

  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final Color colorDisabled = Theme.of(context).primaryColor.withAlpha(100);
    // trabalha melhor com alinhamento
    return Stack(
      children: <Widget>[
        Positioned(
          top: 7,
          left: 7,
          right: 7,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: colorDisabled,
                ),
              ),
              // pega o texto digitado
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text.trim());
              },
            ),
          ),
        ),
      ],
    );
  }
}
