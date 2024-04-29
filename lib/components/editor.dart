import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final String _placeholder;
  final IconData? _icon;

  Editor(
      {super.key,
      required TextEditingController controller,
      required String label,
      required String placeholder,
      IconData? icon})
      : _icon = icon,
        _placeholder = placeholder,
        _label = label,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: const TextStyle(fontSize: 24),
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        icon: _icon != null ? Icon(_icon) : null,
        iconColor: Colors.green,
        labelText: _label,
        hintText: _placeholder,
      ),
    );
  }
}
