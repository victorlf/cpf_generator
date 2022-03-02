import 'package:flutter/material.dart';

class CpfStore extends ChangeNotifier {
  int cpf;

  CpfStore({this.cpf = 0});

  void add() {
    cpf++;
    notifyListeners();
  }
}
