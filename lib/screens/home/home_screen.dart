import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/screens/home/components/body.dart';
import 'package:gerenciadorgastospessoais/screens/home/components/speed_dial.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        
      ),
      floatingActionButton: buildSpeedDial(context),
    );
  }
}
