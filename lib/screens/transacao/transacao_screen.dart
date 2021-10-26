import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/screens/transacao/components/body.dart';

class TransacaoScreen extends StatelessWidget {
  const TransacaoScreen({Key? key}) : super(key: key);

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
