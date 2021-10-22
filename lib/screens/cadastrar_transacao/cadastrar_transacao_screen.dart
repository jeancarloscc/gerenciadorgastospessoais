import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorgastospessoais/models/conta.dart';
import 'package:gerenciadorgastospessoais/models/transacao.dart';
import 'package:gerenciadorgastospessoais/services/conta_service.dart';
import 'package:gerenciadorgastospessoais/services/transacao_service.dart';

class CadastrarTransacaoScreen extends StatefulWidget {
  const CadastrarTransacaoScreen({Key? key, required this.tipoTransacao})
      : super(key: key);

  final int tipoTransacao;

  @override
  _CadastrarTransacaoScreenState createState() =>
      _CadastrarTransacaoScreenState();
}

class _CadastrarTransacaoScreenState extends State<CadastrarTransacaoScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  Conta? _contaSelecionada;
  ContaService cs = ContaService();
  Future<List>? _loadContas;
  List<Conta>? _contas;
  DateTime selectedDate = DateTime.now();
  TransacaoService ts = TransacaoService();

  @override
  void initState() {
    // TODO: implement initState
    _loadContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Transação"),
        backgroundColor: widget.tipoTransacao == 1 ? Colors.blue : Colors.red,
      ),
      body: FutureBuilder(
        future: _loadContas,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _contas = snapshot.data;
            return SingleChildScrollView(
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
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Valor"),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dataController,
                            decoration: InputDecoration(
                                labelText:
                                    formatDate(selectedDate, [dd, "/", mm, "/", yyyy])),
                          ),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _contaSelecionada,
                        onChanged: (Conta? conta) {
                          setState(() {
                            _contaSelecionada = conta;
                          });
                        },
                        items: _contas!.map((conta) {
                          return DropdownMenuItem<Conta>(
                            value: conta,
                            child: Text(conta.titulo.toString()),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Transacao newTransacao = Transacao(
                                  titulo: _tituloController.text,
                                  descricao: _descricaoController.text,
                                  tipo: widget.tipoTransacao,
                                  valor: double.parse(_valorController.text),
                                  data: selectedDate.toString(),
                                  conta: _contaSelecionada!.id
                                );
                                ts.addTransacao(newTransacao);
                              },
                              child: Text("Cadastrar"),
                              style: ElevatedButton.styleFrom(
                                  primary: widget.tipoTransacao == 1
                                      ? Colors.blue
                                      : Colors.red),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 01),
        lastDate: DateTime(2030, 01)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<List> _getContas() async {
    return await cs.getAllConta();
  }
}
