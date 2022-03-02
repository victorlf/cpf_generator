import 'package:cpf_generator/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cpfStore = CpfStore();

  @override
  void initState() {
    super.initState();
    cpfStore.addListener(() {
      setState(() {});
    });
  }

  void _incrementCounter() {
    cpfStore.add();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPF Generator and Validator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              inputFormatters: [CpfMask()],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
              validator: (value) {
                /// TODO: Valiate the text in realtime, so the
                /// validation button is only enabled when the
                /// CPF field is completely filled
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
