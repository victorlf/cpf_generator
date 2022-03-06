import 'package:cpf_generator/models/cpf_model.dart';
import 'package:cpf_generator/utils/cpf_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// 747.123.830-54 valid
  /// 529.982.247-25 valid
  /// 111.111.111-11 not valid
  /// 222.222.222-22 not valid

  // final cpfModel = CpfModel('132.534.542-31');
  // final result = cpfModel.validate();
  // print(result);

  // final cpfGenerator = CpfGenerator();
  // final generatedCpfModel = cpfGenerator.generateCpf();
  // debugPrint(generatedCpfModel.value);
  // final genResult = generatedCpfModel.validate();
  // debugPrint(genResult.toString());

  group('CpfModel instance', () {
    test('Should return a instance of CpfModel', () {
      final result = CpfModel('747.123.830-54');
      expect(result, isA<CpfModel>());
    });

    test(
        'Should return a instance error due incorrect CPF format due lack of punctuation)',
        () {
      expect(() => CpfModel('74712383054'), throwsAssertionError);
    });

    test(
        'Should return a instance error due incorrect CPF format due missing digit(s)',
        () {
      expect(() => CpfModel('747.123.830-5'), throwsAssertionError);
    });

    test(
        'Should return a instance error due incorrect CPF format 3 due extra digit(s)',
        () {
      expect(() => CpfModel('747.123.830-544'), throwsAssertionError);
    });
  });

  group('CpfModel.validation', () {
    test('Should return true if CPF is valid', () {
      final cpfModel = CpfModel('747.123.830-54');
      final result = cpfModel.validate();
      expect(result, true);
    });

    test('Should return false if CPF is not valid due incorrect digit(s)', () {
      final cpfModel = CpfModel('747.123.830-55');
      final result = cpfModel.validate();
      expect(result, false);
    });

    test('Should return false if CPF is not valid due all digits being equal',
        () {
      final cpfModel = CpfModel('111.111.111-11');
      final result = cpfModel.validate();
      expect(result, false);
    });
  });

  group('CpfGenerator', () {
    test('Should return a instance of CpfModel', () {
      final cpfGenerator = CpfGenerator();
      final result = cpfGenerator.generateCpf();
      expect(result, isA<CpfModel>());
    });

    test('Should return true if CPF is valid', () {
      final cpfGenerator = CpfGenerator();
      final generatedCpfModel = cpfGenerator.generateCpf();
      final result = generatedCpfModel.validate();
      expect(result, true);
    });
  });
}
