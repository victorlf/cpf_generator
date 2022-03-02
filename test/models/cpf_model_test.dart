import 'package:cpf_generator/models/cpf_model.dart';
import 'package:cpf_generator/utils/cpf_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// 747.123.830-54 valid
  /// 529.982.247-25 valid
  /// 111.111.111-11 not valid
  /// 222.222.222-22 not valid

  // final cpfModel = CpfModel('132.534.542-31');
  // final result = cpfModel.validate();
  // print(result);

  final cpfGenerator = CpfGenerator();
  final generatedCpfModel = cpfGenerator.generateCpf();
  print(generatedCpfModel.value);
  final genResult = generatedCpfModel.validate();
  print(genResult);
}
