import 'package:cpf_generator/stores/home_store.dart';
import 'package:cpf_generator/utils/cpf_mask.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cpfStore = CpfStore();
  late TextEditingController controller;

  void genetateCpf(TextEditingController controller) {
    cpfStore.genetateCpf(controller);
  }

  void validateCpf(TextEditingController controller) {
    cpfStore.validateCpf(controller);
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    cpfStore.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            Text(
              cpfStore.validationMessage,
              style: TextStyle(
                color: cpfStore.messageColor,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: controller,
              inputFormatters: [CpfMask()],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    genetateCpf(controller);
                  },
                  child: const Text('Generate CPF'),
                ),
                ElevatedButton(
                  onPressed: () {
                    validateCpf(controller);
                  },
                  child: const Text('Validate CPF'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
