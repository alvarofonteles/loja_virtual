import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({this.size, this.onRemove, super.key});

  final ItemSize? size;

  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            initialValue: size!.name,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 30,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            initialValue: size!.stock?.toString(),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 40,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$ ',
            ),
            initialValue: size!.price?.toStringAsFixed(2),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        const CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
        ),
        const CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
        ),
      ],
    );
  }
}
