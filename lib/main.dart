// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() => runApp(const ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

// Formulário para criar uma transferência
class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

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
        title: const Text('Criar transferência'),
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Editor(
              controller: _controladorCampoNumeroConta,
              label: 'Número da contra',
              placeholder: '0000',
            ),
            Editor(
              controller: _controladorCampoValor,
              label: 'Valor',
              placeholder: '0000',
              icon: Icons.monetization_on,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    criarTransferencia(context);
                  },
                  child: const Text('Confirmar')),
            ),
          ],
        ),
      ),
    );
  }

  void criarTransferencia(BuildContext context) {
    final int? accountNumber = int.tryParse(_controladorCampoNumeroConta.text);

    final double? accountValue = double.tryParse(_controladorCampoValor.text);

    if (accountNumber != null && accountValue != null) {
      final transferenciaCriada = Transferencia(accountValue, accountNumber);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$transferenciaCriada'),
        ),
      );
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final String _placeholder;
  final IconData? _icon;

  Editor(
      {super.key,
      required TextEditingController controller,
      required String label,
      required String placeholder,
      IconData? icon})
      : _icon = icon,
        _placeholder = placeholder,
        _label = label,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: const TextStyle(fontSize: 24),
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        icon: _icon != null ? Icon(_icon) : null,
        iconColor: Colors.green,
        labelText: _label,
        hintText: _placeholder,
      ),
    );
  }
}

// Lista de transferências
class ListaTransferencia extends StatefulWidget {
  ListaTransferencia({super.key});
  final List<Transferencia> _transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
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
        title: const Text('Transferências'),
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          final transferencia = widget._transferencias[index];
          return ItemTransferencia(transferencia);
        },
        padding: const EdgeInsets.all(10),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Card de transferência
class Transferencia {
  final double accountValue;
  final int accountNumber;

  Transferencia(this.accountValue, this.accountNumber);

  @override
  String toString() {
    return 'Transferência{valor: $accountValue, numeroConta: $accountNumber}  ';
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        tileColor: Colors.lightGreen[100],
        iconColor: Colors.green,
        leading: const Icon(Icons.monetization_on),
        title: Text('Valor: R\$ ${_transferencia.accountValue}'),
        subtitle: Text('Número da conta: ${_transferencia.accountNumber}'),
      ),
    );
  }
}
