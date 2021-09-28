
import 'package:gerenciadorgastospessoais/models/conta.dart';
import 'package:gerenciadorgastospessoais/utils/db_util.dart';

class ContaService {

  List<Conta> _contaList = [];

  void addConta(Conta conta) {
    DbUtil.insertData('conta', conta.toMap());
  }

  Future<List> getAllConta() async {
    final dataList = await DbUtil.getData('conta');
    _contaList = dataList .map((contas) => Conta.fromMap(contas)).toList();
    return _contaList;
  }
}