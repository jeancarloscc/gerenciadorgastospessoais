import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/screens/home/components/card_conta.dart';
import 'package:gerenciadorgastospessoais/services/conta_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService cs = ContaService();
  late Future<List> _loadContas;
  late List _contas;

  @override
  void initState() {
    // TODO: implement initState
    _loadContas = _getContas();
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
                if(snapshot.hasData){
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
                } else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<List> _getContas() async{
    return await cs.getAllConta();
  }
}
