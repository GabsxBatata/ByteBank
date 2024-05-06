import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/Formulario.dart';
import 'package:flutter/material.dart';

class ListaTransferencia extends StatefulWidget {
  ListaTransferencia({super.key});
  final List<Transferencia> _transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

const _titleAppBar = 'Transferência';

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
        title: const Text(_titleAppBar),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormularioTransferencia();
              },
            ),
          ).then(
            (transferenciaRecebida) => _update(transferenciaRecebida),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _update(transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() => widget._transferencias.add(transferenciaRecebida));
    }
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
