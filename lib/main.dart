import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:gerenciador_gastos_pessoais/screens/cadastrar_transacao/cadastrar_transacao_screen.dart';
import 'package:gerenciador_gastos_pessoais/screens/home/home_screen.dart';

void main()=>runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CadastrarTransacaoScreen(tipoTransacao: 1,),
      home: HomeScreen()
    );
  }
}
