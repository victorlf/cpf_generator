import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpfMask implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 14 ||
        !RegExp(r'^([\d-.]+)?$').hasMatch(newValue.text)) {
      return oldValue;
    }

    var cpf = newValue.text.replaceAll(RegExp(r'\D'), '');
    final characteres = cpf.characters.toList();
    var formattedCpf = '';

    for (var i = 0; i < characteres.length; i++) {
      if (i == 3 || i == 6) {
        formattedCpf += '.';
        formattedCpf += characteres[i];
      } else if (i == 9) {
        formattedCpf += '-';
        formattedCpf += characteres[i];
      } else {
        formattedCpf += characteres[i];
      }
    }

    return newValue.copyWith(
      text: formattedCpf,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formattedCpf.length),
      ),
    );
  }
}
