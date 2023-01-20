import 'package:gerenciador_gastos_pessoais/models/transacao.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_service.dart';
import 'package:gerenciador_gastos_pessoais/utils/db_util.dart';

class TransacaoService {

  List<Transacao> _transacaoList = [];
  ContaService cs = ContaService();

  void addTransacao(Transacao transacao) {
    DbUtil.insertData('transacao', transacao.toMap());
    cs.editSaldoConta(transacao.conta, transacao.valor, transacao.tipo);
  }

  Future<List> getAllTransacoes() async {
    final dataList = await DbUtil.getData('transacao');
    _transacaoList = dataList.map((transacoes) => Transacao.fromMap(transacoes)).toList();
    return _transacaoList;
  }

  Future<List> getTransacoesConta(int id) async {
    String whereString = "conta = ?";
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere('transacao',
        whereString, whereArguments);
    return dataList.map((transacao) => Transacao.fromMap(transacao)).toList();

  }

}