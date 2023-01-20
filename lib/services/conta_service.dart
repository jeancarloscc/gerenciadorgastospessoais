
import 'package:gerenciador_gastos_pessoais/models/conta.dart';
import 'package:gerenciador_gastos_pessoais/utils/db_util.dart';

class ContaService {
  List<Conta> _contaList = [];

  void addConta(Conta conta) {
    DbUtil.insertData('conta', conta.toMap());
  }

  Future<List> getAllContas() async {
    final dataList = await DbUtil.getData('conta');
    _contaList = dataList.map((contas) => Conta.fromMap(contas)).toList();
    return _contaList;
  }

  Future<Conta> getConta(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere('conta',
        whereString, whereArguments);
    return Conta.fromMap(dataList.first);
  }

  void editSaldoConta(int id, double valor, int tipoTransacao) {
    String sql;
    if (tipoTransacao == 1) {
      sql = "UPDATE conta SET saldo = saldo + ? WHERE id = ?";
    } else {
      sql = "UPDATE conta SET saldo = saldo - ? WHERE id = ?";
    }
    List<dynamic> arguments = [valor, id];
    DbUtil.executeSQL(sql, arguments);
  }
}