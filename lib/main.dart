// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() => runApp(const ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
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
      appBar: ComponentAppBar(AppBarName('Criar transferência')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
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
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final String _placeholder;
  final IconData? _icon;

  const Editor(
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
class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComponentAppBar(AppBarName('Transferências')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ItemTransferencia(Transferencia(100, 200)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Componente para app bar
class AppBarName {
  final String name;

  AppBarName(this.name);
}

class ComponentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarName _name;

  const ComponentAppBar(this._name, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(8),
          bottomEnd: Radius.circular(8),
        ),
      ),
      title: Text(_name.name),
      titleTextStyle: const TextStyle(
          color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: Colors.green,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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