import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldEntry extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  TextInputType inputType;
  List<TextInputFormatter>? formatters = [
    FilteringTextInputFormatter.singleLineFormatter
  ];

  FieldEntry(this.hint, this.controller, this.validator,
      {this.formatters, this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: formatters != null ? formatters! : [],
        keyboardType: inputType,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 16.0),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: validator,
      ),
    );
  }
}
