import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // trabalha melhor com alinhamento
    return Stack(
      children: <Widget>[
        Positioned(
          top: 6,
          left: 6,
          right: 6,
          child: Card(
            child: TextFormField(
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
                  color: Colors.grey.shade700,
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
