import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/screens/conta/components/body.dart';

class ContaScreen extends StatelessWidget {

  final int? id;
  ContaScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id,),
    );
  }
}
