import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/models/conta.dart';
import 'package:gerenciadorgastospessoais/screens/home/home_screen.dart';
import 'package:gerenciadorgastospessoais/services/conta_service.dart';

class CadastrarContaScreen extends StatelessWidget {
  final _tituloController = TextEditingController();
  final _saldoController = TextEditingController();

  ContaService cs = ContaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de conta"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tituloController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Título"),
              ),
              TextFormField(
                controller: _saldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Saldo"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Conta newConta = Conta(
                        titulo: _tituloController.text,
                        saldo: double.parse(_saldoController.text)
                      );
                      cs.addConta(newConta);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => HomeScreen()
                        )
                      );
                    },
                    child: Text("Cadastrar"),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
