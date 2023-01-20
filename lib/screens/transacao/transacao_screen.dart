import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/screens/transacao/components/body.dart';

class TransacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Body(),
    );
  }
}
