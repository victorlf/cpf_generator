import 'package:flutter/material.dart';

import 'package:cpf_generator/models/cpf_model.dart';
import 'package:cpf_generator/utils/cpf_generator.dart';

class CpfStore extends ChangeNotifier {
  String validationMessage;
  Color messageColor;

  CpfStore(
      {this.validationMessage = 'Let\'s Validate',
      this.messageColor = Colors.black});

  void genetateCpf(TextEditingController controller) {
    final cpfGenerator = CpfGenerator();
    final cpfModel = cpfGenerator.generateCpf();

    controller.text = cpfModel.value;

    notifyListeners();
  }

  void validateCpf(TextEditingController controller) {
    final cpf = controller.text;
    if (cpf.characters.length < 14) {
      validationMessage = 'CPF not filled correctly';
      messageColor = Colors.yellow.shade700;

      notifyListeners();

      return;
    }

    final cpfModel = CpfModel(cpf);

    final isValid = cpfModel.validate();

    if (isValid) {
      validationMessage = 'Valid CPF';
      messageColor = Colors.green;
    } else {
      validationMessage = 'CPF Not Valid';
      messageColor = Colors.red;
    }

    notifyListeners();
  }
}
