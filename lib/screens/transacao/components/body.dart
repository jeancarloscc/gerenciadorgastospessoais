import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/models/transacao.dart';
import 'package:gerenciadorgastospessoais/screens/components/card_transacao.dart';
import 'package:gerenciadorgastospessoais/services/transacao_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TransacaoService ts = TransacaoService();
  Future<List>? _loadTransacoes;
  late List<Transacao> _transacoes;

  @override
  void initState() {
    // TODO: implement initState
    _loadTransacoes = _getTransacoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 60, top: 67, bottom: 16, right: 24),
          child: Row(
            children: [
              Text(
                "Todas as transações",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black),
              )
            ],
          ),
        ),
        FutureBuilder(
            future: _loadTransacoes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _transacoes = snapshot.data;
                return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _transacoes.length,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return cardTransacao(
                              context, index, _transacoes[index]);
                        }));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    );
  }

  Future<List> _getTransacoes() async {
    return await ts.getAllTransacoes();
  }
}
