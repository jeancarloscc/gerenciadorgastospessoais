import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/screens/components/card_conta.dart';
import 'package:gerenciador_gastos_pessoais/screens/components/card_transacao.dart';
import 'package:gerenciador_gastos_pessoais/screens/transacao/transacao_screen.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_service.dart';
import 'package:gerenciador_gastos_pessoais/services/transacao_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService cs = ContaService();
  TransacaoService ts = TransacaoService();
  Future<List> _loadContas;
  Future<List> _loadTransacoes;
  List _contas;
  List _transacoes;

  @override
  void initState() {
    // TODO: implement initState
    _loadContas = _getContas();
    _loadTransacoes = _getTransacoes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175,
            child: FutureBuilder(
              future: _loadContas,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _contas = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _contas.length,
                      padding: EdgeInsets.only(left: 16, right: 8),
                      itemBuilder: (context, index) {
                        return cardConta(context, _contas[index]);
                      }
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Últimas transações",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                  color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => TransacaoScreen()
                        )
                    );
                  },
                  child: Text(
                    "Ver todas",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
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
                      itemCount: _transacoes.length > 8 ? 8 : _transacoes.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                      return cardTransacao(context, index, _transacoes[index]);
                      }
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ],
      ),
    );
  }

  Future<List> _getContas() async {
    return await cs.getAllContas();
  }

  Future<List> _getTransacoes() async {
    return await ts.getAllTransacoes();
  }
}
