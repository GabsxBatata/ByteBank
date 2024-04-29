import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criar transferência';
const _labelValue = 'Valor';
const _placeholderValue = '0.00';
const _placeholderAccount = '0000';
const _labelAccount = 'Criar transferência';
const _buttonText = 'Criar transferência';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  void criarTransferencia(BuildContext context) {
    final int? accountNumber = int.tryParse(_controladorCampoNumeroConta.text);

    final double? accountValue = double.tryParse(_controladorCampoValor.text);

    if (accountNumber != null && accountValue != null) {
      final transferenciaCriada = Transferencia(accountValue, accountNumber);
      Navigator.pop(context, transferenciaCriada);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(8),
            bottomEnd: Radius.circular(8),
          ),
        ),
        title: const Text(_tituloAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                controller: _controladorCampoNumeroConta,
                label: _labelAccount,
                placeholder: _placeholderAccount,
              ),
              Editor(
                controller: _controladorCampoValor,
                label: _labelValue,
                placeholder: _placeholderValue,
                icon: Icons.monetization_on,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    criarTransferencia(context);
                  },
                  child: const Text(_buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
