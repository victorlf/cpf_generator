import 'package:cpf_generator/models/cpf_model.dart';
import 'package:cpf_generator/utils/random_number.dart';
import 'package:flutter/material.dart';

class CpfGenerator {
  List<dynamic> _generateFirst9Digits() {
    final number = RandomNumber().nextInter(100000000, 999999999).toString();
    final numbersStringList = number.split('');
    debugPrint(number);
    return [number, numbersStringList];
  }

  bool _verifyRepetition(List<String> numbersStringList) {
    var areRepeatedNumbers =
        numbersStringList.every((element) => element == numbersStringList[0]);

    return areRepeatedNumbers;
  }

  int _generateVerificationDigit(List<int> cpfNumbers, int lastIndex) {
    var result = 0;
    var count = lastIndex + 1;
    for (var i = 0; i < lastIndex; i++) {
      result += cpfNumbers[i] * count;
      count -= 1;
    }

    result = result * 10;
    final digit = result % 11;

    return digit;
  }

  CpfModel generateCpf() {
    var numberAndList = _generateFirst9Digits();
    String number = numberAndList[0];
    List<String> numbersStringList = numberAndList[1];
    while (_verifyRepetition(numbersStringList)) {
      numberAndList = _generateFirst9Digits();
      number = numberAndList[0];
      numbersStringList = numberAndList[1];
      debugPrint('got intp here');
    }

    var numbersList = numbersStringList.map((e) => int.parse(e)).toList();

    final digit1 = _generateVerificationDigit(numbersList, 9);
    numbersList.add(digit1);
    final digit2 = _generateVerificationDigit(numbersList, 10);

    var cpf = number.substring(0, 3) +
        '.' +
        number.substring(3, 6) +
        '.' +
        number.substring(6, 9);

    cpf = cpf + '-$digit1$digit2';

    return CpfModel(cpf);
  }
}
