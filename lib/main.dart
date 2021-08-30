// ignore: unused_import
import 'dart:ffi';
import 'package:flutter/material.dart';

void main() => runApp(BitBankApp()); //EXECUTA A CLASSE PRINCIPAL, TELA HOME

//*-----------------------------------------------------------------------------
//------------------------------ VIEW PRINCIPAL  -------------------------------
class BitBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ViewTransferencia(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

//*-----------------------------------------------------------------------------
//*--------------------------  VIEW TRANSFERENCIA ------------------------------
class ViewTransferencia extends StatelessWidget {
  //
  //*VARIAVEIS PRIVADAS
  final TextEditingController _controllerNumeroConta =
      new TextEditingController();
  final TextEditingController _controllerValorSaque =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transferencias")),
      body: Column(
        children: <Widget>[
          Editor(
              controlador: _controllerNumeroConta,
              rotulo: "Numero da Conta",
              dica: "0000-0"),
          Editor(
            controlador: _controllerValorSaque,
            rotulo: "Valor do Saque",
            dica: "00.00",
          ),
          ElevatedButton(
            child: Text("Confirmar"),
            onPressed: () => _criaTranferencia(),
          ),
        ],
      ),
    );
  }

//*METODO CLICK BOTAO CONFIRMAR
  void _criaTranferencia() {
    final int? numeroContaText = int.tryParse(_controllerNumeroConta.text);
    final double? valorSaqueText = double.tryParse(_controllerValorSaque.text);
    if (numeroContaText != null && valorSaqueText != null) {
      Transferencia(valorSaqueText, numeroContaText.toString());
    }
  }
}

//*EDITOR GENERICO
// ignore: must_be_immutable
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;

//*CONSTRUTOR
  Editor({required this.controlador, required this.rotulo, required this.dica});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
            // ignore: unnecessary_null_comparison
            // icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

//------------------------------------------------------------------------------
//*---------  CLASSES STATELESSWIDGETS - SAO WIDGETS QUE NAO VAO MUDAR. --------
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bit Bank'),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(200, "123456-2")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

//*-----------------------------------------------------------------------------
//*-----------------  ITEM DA TRANSFERENCIA VALORES  ---------------------------
class ItemTransferencia extends StatelessWidget {
  final Transferencia _tranferencia;

//
//*CONSTRUTOR
  ItemTransferencia(this._tranferencia) {}

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text("Saque: " + _tranferencia.saque.toString()),
            subtitle: Text("Ct: " + _tranferencia.numeroConta)));
  }
}

//*-----------------------------------------------------------------------------
//*----------------------  CLASSE TRANSFERENCIA  -------------------------------
class Transferencia {
  final double saque;
  final String numeroConta;

  Transferencia(this.saque, this.numeroConta);
}
